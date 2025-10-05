module Bin.Util.Log.Pending
  ( pending
  , pendingAfterNewline
  , pendingColor
  , pendingColorize
  , pendingEmoji
  , pendingPrefixed
  , pendingShort
  , pendingShortAfterNewline
  , pendingShortShow
  , pendingShortShowAfterNewline
  , pendingShow
  , pendingShowAfterNewline
  )
  where

import Prelude

import Ansi.Codes (Color(..))
import Bin.Util.Log (colorize, newline, prefixed)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console

pendingColor :: Color
pendingColor = BrightBlack

pendingColorize :: String -> String
pendingColorize = colorize pendingColor

pending :: forall m. MonadEffect m => String -> m Unit
pending = liftEffect <<< Console.log <<< (\m -> pendingPrefixed m false false)

pendingAfterNewline :: forall m. MonadEffect m => String -> m Unit
pendingAfterNewline msg = newline *> pending msg

pendingShort :: forall m. MonadEffect m => String -> m Unit
pendingShort = liftEffect <<< Console.log <<< (\m -> pendingPrefixed m true false)

pendingShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
pendingShortAfterNewline msg = newline *> pendingShort msg

pendingShortShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
pendingShortShowAfterNewline = pendingShortAfterNewline <<< show

pendingShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
pendingShortShow = pendingShort <<< show

pendingShow :: forall m a. MonadEffect m => Show a => a -> m Unit
pendingShow = pending <<< show

pendingShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
pendingShowAfterNewline = pendingAfterNewline <<< show

pendingEmoji :: String
pendingEmoji = "⏳"

pendingPrefixed :: String -> Boolean -> Boolean -> String
pendingPrefixed msg short colorize = prefixed "pending" pendingColor pendingEmoji msg short colorize