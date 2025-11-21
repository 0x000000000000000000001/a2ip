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
  , errorShortShowAfterNewline
  , errorShow
  , errorShowAfterNewline
  )
  where

import Proem

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Console as Console

errorColor :: Color
errorColor = Red

errorColorize :: String -> String
errorColorize = colorize errorColor

error :: ∀ m. MonadAff m => String -> m Unit
error = ʌ ◁ Console.log ◁ (\m -> errorPrefixed m false false)

errorAfterNewline :: ∀ m. MonadAff m => String -> m Unit
errorAfterNewline msg = newline *> error msg

errorShort :: ∀ m. MonadAff m => String -> m Unit
errorShort = ʌ ◁ Console.log ◁ (\m -> errorPrefixed m true false)

errorShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
errorShortAfterNewline msg = newline *> errorShort msg

errorShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
errorShortShowAfterNewline = errorShortAfterNewline ◁ show

errorShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
errorShortShow = errorShort ◁ show

errorShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
errorShow = error ◁ show

errorShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
errorShowAfterNewline = errorAfterNewline ◁ show

errorEmoji :: String
errorEmoji = "❌"

errorPrefixed :: String -> Boolean -> Boolean -> String
errorPrefixed msg short colorize = prefixed "error" errorColor errorEmoji msg short colorize 