module Bin.Util.Log.Error
  ( error
  , errorAfterNewline
  , errorColor
  , errorColorize
  , errorEmoji
  , errorPrefixed
  , errorShort
  , errorShortAfterNewline
  , errorShortShow
  , errorShow
  , errorShowAfterNewline
  )
  where

import Prelude

import Bin.Util.Log (CliColor(..), colorize, newline, prefixed)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console

errorColor :: CliColor
errorColor = Red

errorColorize :: String -> String
errorColorize = colorize errorColor

error :: forall m. MonadEffect m => String -> m Unit
error = liftEffect <<< Console.log <<< (\m -> errorPrefixed m false false)

errorAfterNewline :: forall m. MonadEffect m => String -> m Unit
errorAfterNewline msg = newline *> error msg

errorShort :: forall m. MonadEffect m => String -> m Unit
errorShort = liftEffect <<< Console.log <<< (\m -> errorPrefixed m true false)

errorShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
errorShortAfterNewline msg = newline *> errorShort msg

errorShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShortShow = errorShort <<< show

errorShow :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShow = error <<< show

errorShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShowAfterNewline = errorAfterNewline <<< show

errorEmoji :: String
errorEmoji = "❌"

errorPrefixed :: String -> Boolean -> Boolean -> String
errorPrefixed msg short colorize = prefixed "error" errorColor errorEmoji msg short colorize 