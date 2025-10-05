module Capability.Log where

import Prelude

import Capability.AppM (AppM)
import Control.Monad.Trans.Class (lift)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect.Class.Console as Console
import Halogen (HalogenM)

data Level = Debug | Info | Warning | Error

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
      Warning -> Console.warn msg
      Error -> Console.error msg
  logShow level a = log level (show a)
  info msg = log Info msg
  infoShow a = logShow Info a
  debug msg = log Debug msg
  debugShow a = logShow Debug a
  warn msg = log Warning msg
  warnShow a = logShow Warning a
  error msg = log Error msg
  errorShow a = logShow Error a

derive instance genericLogLevel :: Generic Level _

instance showLogLevel :: Show Level where
  show = genericShow
