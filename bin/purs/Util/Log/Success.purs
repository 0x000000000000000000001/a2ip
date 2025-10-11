module Bin.Util.Log.Success
  ( success
  , successAfterNewline
  , successColor
  , successColorize
  , successEmoji
  , successPrefixed
  , successShort
  , successShortAfterNewline
  , successShortShow
  , successShortShowAfterNewline
  , successShow
  , successShowAfterNewline
  )
  where

import Proem

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

successColor :: Color
successColor = Green

successColorize :: String -> String
successColorize = colorize successColor

success :: ∀ m. MonadAff m => String -> m Unit
success = liftEffect <<< Console.log <<< (\m -> successPrefixed m false false)

successAfterNewline :: ∀ m. MonadAff m => String -> m Unit
successAfterNewline msg = newline *> success msg

successShort :: ∀ m. MonadAff m => String -> m Unit
successShort = liftEffect <<< Console.log <<< (\m -> successPrefixed m true false)

successShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
successShortAfterNewline msg = newline *> successShort msg

successShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
successShortShowAfterNewline = successShortAfterNewline <<< show

successShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
successShortShow = successShort <<< show

successShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
successShow = success <<< show

successShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
successShowAfterNewline = successAfterNewline <<< show

successEmoji :: String
successEmoji = "✅"

successPrefixed :: String -> Boolean -> Boolean -> String
successPrefixed msg short colorize = prefixed "success" successColor successEmoji msg short colorize