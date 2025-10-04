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
  , debugShow
  , debugShowAfterNewline
  )
  where

import Prelude

import Ansi.Codes (Color(..))
import Bin.Util.Log (colorize, newline, prefixed)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console

debugColor :: Color
debugColor = Magenta
 
debugColorize :: String -> String
debugColorize = colorize debugColor

debug :: forall m. MonadEffect m => String -> m Unit
debug = liftEffect <<< Console.log <<< (\m -> debugPrefixed m false false)

debugAfterNewline :: forall m. MonadEffect m => String -> m Unit
debugAfterNewline msg = newline *> debug msg

debugShort :: forall m. MonadEffect m => String -> m Unit
debugShort = liftEffect <<< Console.log <<< (\m -> debugPrefixed m true false)

debugShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
debugShortAfterNewline msg = newline *> debugShort msg

debugShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShortShow = debugShort <<< show

debugShow :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShow = debug <<< show

debugShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShowAfterNewline = debugAfterNewline <<< show

debugEmoji :: String
debugEmoji = "🪲 "

debugPrefixed :: String -> Boolean -> Boolean -> String
debugPrefixed msg short colorize = prefixed "debug" debugColor debugEmoji msg short colorize