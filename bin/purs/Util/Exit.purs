module Bin.Util.Exit
  ( exit
  , exitError
  , exitSuccess
  )
  where

import Proem

import Effect.Class (class MonadEffect, liftEffect)
import Node.Process (exit')

exit :: forall m a. MonadEffect m => Int -> m a 
exit = liftEffect <<< exit'

exitSuccess :: forall m a. MonadEffect m => m a 
exitSuccess = exit 0

exitError :: forall m a. MonadEffect m => m a 
exitError = exit 1