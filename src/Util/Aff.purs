module Util.Aff
  ( keepProcessAlive
  )
  where

import Prelude
import Effect.Aff (Aff, bracket)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Util.Effect.Timer (IntervalId, clearInterval, setInterval)

-- | Wraps an Aff action, ensuring the Node.js process does not exit prematurely
-- | by creating a timer that is active for the duration of the Aff.
keepProcessAlive :: forall a. Aff a -> Aff a
keepProcessAlive action =
  bracket acquire release \_ -> action
  where
  -- Action to acquire the resource (start the timer)
  acquire :: Aff IntervalId
  acquire = do
    liftEffect $ log "==> Acquiring keep-alive timer..."
    id <- liftEffect $ setInterval 10000 (pure unit) -- A timer that does nothing every 10s
    liftEffect $ log "==> Timer acquired."
    pure id

  -- Action to release the resource (clear the timer)
  release :: IntervalId -> Aff Unit
  release id = do
    liftEffect $ log "==> Releasing keep-alive timer..."
    liftEffect $ clearInterval id
    liftEffect $ log "==> Timer released."
