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
  , infoShow
  , infoShowAfterNewline
  )
  where

import Prelude

import Bin.Util.Log (CliColor(..), colorize, newline, prefixed)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console

infoColor :: CliColor
infoColor = Blue

infoColorize :: String -> String
infoColorize = colorize infoColor

info :: forall m. MonadEffect m => String -> m Unit
info = liftEffect <<< Console.log <<< (\m -> infoPrefixed m false)

infoAfterNewline :: forall m. MonadEffect m => String -> m Unit
infoAfterNewline msg = newline *> info msg

infoShort :: forall m. MonadEffect m => String -> m Unit
infoShort = liftEffect <<< Console.log <<< (\m -> infoPrefixed m true)

infoShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
infoShortAfterNewline msg = newline *> infoShort msg

infoShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
infoShortShow = infoShort <<< show

infoShow :: forall m a. MonadEffect m => Show a => a -> m Unit
infoShow = info <<< show

infoShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
infoShowAfterNewline = infoAfterNewline <<< show

infoEmoji :: String
infoEmoji = "ℹ️"

infoPrefixed :: String -> Boolean -> Boolean -> String
infoPrefixed msg short colorize = prefixed "info" infoColor infoEmoji msg short colorize