module Util.Aff
  ( keepAlive
  )
  where

import Proem

import Control.Monad.Error.Class (class MonadError, catchError, throwError)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (liftEffect)
import Effect.Exception (Error)
import Util.Effect.Timer (IntervalId, clearInterval, setInterval)

-- | Wraps an Aff action, ensuring the Node.js process does not exit prematurely
-- | by creating a timer handle that is active for the duration of the Aff.
-- | Guarantees cleanup even if the action throws an exception.
keepAlive :: forall m a. MonadAff m => MonadError Error m => m a -> m a
keepAlive action = do
  id <- liftAff acquire
  catchError 
    (do
      result <- action
      liftAff (release id)
      pure result
    )
    (\err -> do
      liftAff (release id)
      throwError err
    )
  where
  -- Action to acquire the resource (start the timer)
  acquire :: Aff IntervalId
  acquire = do
    id <- liftEffect $ setInterval 10000 ηι -- A timer that does nothing every 10s
    pure id

  -- Action to release the resource (clear the timer)
  release :: IntervalId -> Aff Unit
  release id = do
    liftEffect $ clearInterval id