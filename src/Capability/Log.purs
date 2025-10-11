module Capability.Log where

import Proem

import Capability.AppM (AppM)
import Control.Monad.Trans.Class (lift)
import Effect.Class.Console as Console
import Halogen (HalogenM)
import Util.Log (Level(..))

class Monad m <= Log m where
  log :: Level -> String -> m Unit
  logShow :: forall a. Show a => Level -> a -> m Unit
  info :: String -> m Unit
  infoShow :: forall a. Show a => a -> m Unit
  debug :: String -> m Unit
  debugShow :: forall a. Show a => a -> m Unit
  warn :: String -> m Unit
  warnShow :: forall a. Show a => a -> m Unit
  error :: String -> m Unit
  errorShow :: forall a. Show a => a -> m Unit

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

instance logAppM :: Log AppM where 
  log level message = 
    let msg = show level <> ": " <> message
    in case level of 
      Debug -> Console.debug msg
      Info -> Console.info msg
      Warn -> Console.warn msg
      Error -> Console.error msg
  logShow level a = log level (show a)
  info msg = log Info msg
  infoShow a = logShow Info a
  debug msg = log Debug msg
  debugShow a = logShow Debug a
  warn msg = log Warn msg
  warnShow a = logShow Warn a
  error msg = log Error msg
  errorShow a = logShow Error a
