module Bin.Util.Log.Info
  ( info
  , infoAfterNewline
  , infoColor
  , infoColorize
  , infoEmoji
  , infoPrefixed
  , infoShort
  , infoShortAfterNewline
  , infoShortShow
  , infoShortShowAfterNewline
  , infoShow
  , infoShowAfterNewline
  )
  where

import Proem

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

infoColor :: Color
infoColor = Blue

infoColorize :: String -> String
infoColorize = colorize infoColor

info :: ∀ m. MonadAff m => String -> m Unit
info = liftEffect <<< Console.log <<< (\m -> infoPrefixed m false false)

infoAfterNewline :: ∀ m. MonadAff m => String -> m Unit
infoAfterNewline msg = newline *> info msg

infoShort :: ∀ m. MonadAff m => String -> m Unit
infoShort = liftEffect <<< Console.log <<< (\m -> infoPrefixed m true false)

infoShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
infoShortAfterNewline msg = newline *> infoShort msg

infoShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
infoShortShowAfterNewline = infoShortAfterNewline <<< show

infoShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
infoShortShow = infoShort <<< show

infoShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
infoShow = info <<< show

infoShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
infoShowAfterNewline = infoAfterNewline <<< show

infoEmoji :: String
infoEmoji = "ℹ️ "

infoPrefixed :: String -> Boolean -> Boolean -> String
infoPrefixed msg short colorize = prefixed "info" infoColor infoEmoji msg short colorize