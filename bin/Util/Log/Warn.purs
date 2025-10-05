module Bin.Util.Log.Warn
  ( warn
  , warnAfterNewline
  , warnColor
  , warnColorize
  , warnEmoji
  , warnPrefixed
  , warnShort
  , warnShortAfterNewline
  , warnShortShow
  , warnShortShowAfterNewline
  , warnShow
  , warnShowAfterNewline
  )
  where

import Prelude

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console

warnColor :: Color
warnColor = Yellow

warnColorize :: String -> String
warnColorize = colorize warnColor

warn :: forall m. MonadEffect m => String -> m Unit
warn = liftEffect <<< Console.log <<< (\m -> warnPrefixed m false false)

warnAfterNewline :: forall m. MonadEffect m => String -> m Unit
warnAfterNewline msg = newline *> warn msg

warnShort :: forall m. MonadEffect m => String -> m Unit
warnShort = liftEffect <<< Console.log <<< (\m -> warnPrefixed m true false)

warnShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
warnShortAfterNewline msg = newline *> warnShort msg

warnShortShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShortShowAfterNewline = warnShortAfterNewline <<< show

warnShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShortShow = warnShort <<< show

warnShow :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShow = warn <<< show

warnShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShowAfterNewline = warnAfterNewline <<< show

warnEmoji :: String
warnEmoji = "⚠️ "

warnPrefixed :: String -> Boolean -> Boolean -> String
warnPrefixed msg short colorize = prefixed "warn" warnColor warnEmoji msg short colorize