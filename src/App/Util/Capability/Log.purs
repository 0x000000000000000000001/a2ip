module App.Util.Capability.Log where

import Proem

import Halogen (HalogenM)
import Util.Log (Level)
import Control.Monad.Trans.Class (lift)

class Monad m <= Log m where
  log :: Level -> String -> m Unit
  logShow :: ∀ a. Show a => Level -> a -> m Unit
  info :: String -> m Unit
  infoShow :: ∀ a. Show a => a -> m Unit
  debug :: String -> m Unit
  debugShow :: ∀ a. Show a => a -> m Unit
  warn :: String -> m Unit
  warnShow :: ∀ a. Show a => a -> m Unit
  error :: String -> m Unit
  errorShow :: ∀ a. Show a => a -> m Unit

instance logHalogenM :: Log m => Log (HalogenM state action slots output m) where
  log level message = lift $ log level message
  logShow level a = lift $ logShow level a
  info message = lift $ info message
  infoShow a = lift $ infoShow a
  debug message = lift $ debug message
  debugShow a = lift $ debugShow a
  warn message = lift $ warn message
  warnShow a = lift $ warnShow a
  error message = lift $ error message
  errorShow a = lift $ errorShow a
