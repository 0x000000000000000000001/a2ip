module Capability.Log where

import Prelude

import AppM (AppM)
import Control.Monad.Trans.Class (lift)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect.Class.Console as Console
import Halogen (HalogenM)

data Level = Debug | Info | Warning | Error

class Monad m <= Log m where
  log :: Level -> String -> m Unit

instance logHalogenM :: Log m => Log (HalogenM state action slots output m) where
  log level message = lift (log level message)

instance logAppM :: Log AppM where
  log level message = 
    let message_ = show level <> ": " <> message
    in case level of
      Debug -> Console.debug message_
      Info -> Console.info message_
      Warning -> Console.warn message_
      Error -> Console.error message_

derive instance genericLogLevel :: Generic Level _

instance showLogLevel :: Show Level where
  show = genericShow
