module Util.Log
  ( unsafeLog
  , unsafeLogDebug
  ) where

import Prelude

import Capability.Log (Level(..))
import Effect.Console as Console
import Effect.Unsafe (unsafePerformEffect)

unsafeLog :: forall a. Show a => Level -> a -> Unit
unsafeLog level input = unsafePerformEffect $ do
  let message_ = show level <> ": " <> show input
  case level of
    Debug -> Console.debug message_
    Info -> Console.info message_
    Warning -> Console.warn message_
    Error -> Console.error message_

unsafeLogDebug :: forall a. Show a => a -> Unit
unsafeLogDebug = unsafeLog Debug