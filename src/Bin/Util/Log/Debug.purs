module Bin.Util.Log.Debug
  ( debug
  , debugAfterNewline
  , debugColor
  , debugColorize
  , debugEmoji
  , debugPrefixed
  , debugShort
  , debugShortAfterNewline
  , debugShortShow
  , debugShortShowAfterNewline
  , debugShow
  , debugShowAfterNewline
  )
  where

import Proem

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

debugColor :: Color
debugColor = Magenta
 
debugColorize :: String -> String
debugColorize = colorize debugColor

debug :: ∀ m. MonadAff m => String -> m Unit
debug = ʌ ◁ Console.log ◁ (\m -> debugPrefixed m false false)

debugAfterNewline :: ∀ m. MonadAff m => String -> m Unit
debugAfterNewline msg = newline *> debug msg

debugShort :: ∀ m. MonadAff m => String -> m Unit
debugShort = ʌ ◁ Console.log ◁ (\m -> debugPrefixed m true false)

debugShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
debugShortAfterNewline msg = newline *> debugShort msg

debugShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
debugShortShowAfterNewline = debugShortAfterNewline ◁ show

debugShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
debugShortShow = debugShort ◁ show

debugShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
debugShow = debug ◁ show

debugShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
debugShowAfterNewline = debugAfterNewline ◁ show

debugEmoji :: String
debugEmoji = "🪲 "

debugPrefixed :: String -> Boolean -> Boolean -> String
debugPrefixed msg short colorize = prefixed "debug" debugColor debugEmoji msg short colorize