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

import Prelude

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console

successColor :: Color
successColor = Green

successColorize :: String -> String
successColorize = colorize successColor

success :: forall m. MonadEffect m => String -> m Unit
success = liftEffect <<< Console.log <<< (\m -> successPrefixed m false false)

successAfterNewline :: forall m. MonadEffect m => String -> m Unit
successAfterNewline msg = newline *> success msg

successShort :: forall m. MonadEffect m => String -> m Unit
successShort = liftEffect <<< Console.log <<< (\m -> successPrefixed m true false)

successShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
successShortAfterNewline msg = newline *> successShort msg

successShortShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
successShortShowAfterNewline = successShortAfterNewline <<< show

successShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
successShortShow = successShort <<< show

successShow :: forall m a. MonadEffect m => Show a => a -> m Unit
successShow = success <<< show

successShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
successShowAfterNewline = successAfterNewline <<< show

successEmoji :: String
successEmoji = "✅"

successPrefixed :: String -> Boolean -> Boolean -> String
successPrefixed msg short colorize = prefixed "success" successColor successEmoji msg short colorize