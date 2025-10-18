module Util.Aff
  ( keepAlive
  )
  where

import Proem

import Effect.Aff (Aff, bracket, generalBracket)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (liftEffect)
import Util.Effect.Timer (IntervalId, clearInterval, setInterval)

-- | Wraps an Aff action, ensuring the Node.js process does not exit prematurely
-- | by creating a timer handle that is active for the duration of the Aff.
keepAlive :: forall m a. MonadAff m => m a -> m a
keepAlive action = 
  liftAff $ bracket acquire release (\_ -> action)
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