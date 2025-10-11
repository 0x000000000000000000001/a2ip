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

import Proem

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

pendingColor :: Color
pendingColor = BrightBlack

pendingColorize :: String -> String
pendingColorize = colorize pendingColor

pending :: ∀ m. MonadAff m => String -> m Unit
pending = liftEffect <<< Console.log <<< (\m -> pendingPrefixed m false false)

pendingAfterNewline :: ∀ m. MonadAff m => String -> m Unit
pendingAfterNewline msg = newline *> pending msg

pendingShort :: ∀ m. MonadAff m => String -> m Unit
pendingShort = liftEffect <<< Console.log <<< (\m -> pendingPrefixed m true false)

pendingShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
pendingShortAfterNewline msg = newline *> pendingShort msg

pendingShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
pendingShortShowAfterNewline = pendingShortAfterNewline <<< show

pendingShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
pendingShortShow = pendingShort <<< show

pendingShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
pendingShow = pending <<< show

pendingShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
pendingShowAfterNewline = pendingAfterNewline <<< show

pendingEmoji :: String
pendingEmoji = "⏳"

pendingPrefixed :: String -> Boolean -> Boolean -> String
pendingPrefixed msg short colorize = prefixed "pending" pendingColor pendingEmoji msg short colorize