module Util.Log
  ( Level(..)
  , unsafeDebug
  , unsafeDebugShow
  , unsafeError
  , unsafeErrorShow
  , unsafeInfo
  , unsafeInfoShow
  , unsafeLog
  , unsafeLogShow
  , unsafeWarn
  , unsafeWarnShow
  )
  where

import Proem

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect.Console as Console
import Effect.Unsafe (unsafePerformEffect)

data Level = Debug | Info | Warn | Error

derive instance genericLogLevel :: Generic Level _

instance showLogLevel :: Show Level where
  show = genericShow

unsafeLog :: ∀ a. Show a => Level -> a -> Unit
unsafeLog level input = unsafePerformEffect $ do
  let message_ = show level <> ": " <> show input
  case level of
    Debug -> Console.debug message_
    Info -> Console.info message_
    Warn -> Console.warn message_
    Error -> Console.error message_

unsafeLogShow :: ∀ a. Show a => Level -> a -> Unit
unsafeLogShow level input = unsafeLog level $ show input

unsafeDebug :: ∀ a. Show a => a -> Unit
unsafeDebug = unsafeLog Debug

unsafeDebugShow :: ∀ a. Show a => a -> Unit
unsafeDebugShow = unsafeDebug ◁ show

unsafeInfo :: ∀ a. Show a => a -> Unit
unsafeInfo = unsafeLog Info

unsafeInfoShow :: ∀ a. Show a => a -> Unit
unsafeInfoShow = unsafeInfo ◁ show

unsafeWarn :: ∀ a. Show a => a -> Unit
unsafeWarn = unsafeLog Warn

unsafeWarnShow :: ∀ a. Show a => a -> Unit
unsafeWarnShow = unsafeWarn ◁ show

unsafeError :: ∀ a. Show a => a -> Unit
unsafeError = unsafeLog Error

unsafeErrorShow :: ∀ a. Show a => a -> Unit
unsafeErrorShow = unsafeError ◁ show