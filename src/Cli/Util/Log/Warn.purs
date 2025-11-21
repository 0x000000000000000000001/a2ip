module Cli.Util.Log.Warn
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

import Proem

import Ansi.Codes (Color(..))
import Cli.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Console as Console

warnColor :: Color
warnColor = Yellow

warnColorize :: String -> String
warnColorize = colorize warnColor

warn :: ∀ m. MonadAff m => String -> m Unit
warn = ʌ ◁ Console.log ◁ (\m -> warnPrefixed m false false)

warnAfterNewline :: ∀ m. MonadAff m => String -> m Unit
warnAfterNewline msg = newline *> warn msg

warnShort :: ∀ m. MonadAff m => String -> m Unit
warnShort = ʌ ◁ Console.log ◁ (\m -> warnPrefixed m true false)

warnShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
warnShortAfterNewline msg = newline *> warnShort msg

warnShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
warnShortShowAfterNewline = warnShortAfterNewline ◁ show

warnShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
warnShortShow = warnShort ◁ show

warnShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
warnShow = warn ◁ show

warnShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
warnShowAfterNewline = warnAfterNewline ◁ show

warnEmoji :: String
warnEmoji = "⚠️ "

warnPrefixed :: String -> Boolean -> Boolean -> String
warnPrefixed msg short colorize = prefixed "warn" warnColor warnEmoji msg short colorize