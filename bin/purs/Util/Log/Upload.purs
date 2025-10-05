module Bin.Util.Log.Upload
  ( upload
  , uploadAfterNewline
  , uploadColor
  , uploadColorize
  , uploadEmoji
  , uploadPrefixed
  , uploadShort
  , uploadShortAfterNewline
  , uploadShortShow
  , uploadShortShowAfterNewline
  , uploadShow
  , uploadShowAfterNewline
  )
  where

import Prelude

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

uploadColor :: Color
uploadColor = Cyan
 
uploadColorize :: String -> String
uploadColorize = colorize uploadColor

upload :: forall m. MonadAff m => String -> m Unit
upload = liftEffect <<< Console.log <<< (\m -> uploadPrefixed m false false)

uploadAfterNewline :: forall m. MonadAff m => String -> m Unit
uploadAfterNewline msg = newline *> upload msg

uploadShort :: forall m. MonadAff m => String -> m Unit
uploadShort = liftEffect <<< Console.log <<< (\m -> uploadPrefixed m true false)

uploadShortAfterNewline :: forall m. MonadAff m => String -> m Unit
uploadShortAfterNewline msg = newline *> uploadShort msg

uploadShortShowAfterNewline :: forall m a. MonadAff m => Show a => a -> m Unit
uploadShortShowAfterNewline = uploadShortAfterNewline <<< show

uploadShortShow :: forall m a. MonadAff m => Show a => a -> m Unit
uploadShortShow = uploadShort <<< show

uploadShow :: forall m a. MonadAff m => Show a => a -> m Unit
uploadShow = upload <<< show

uploadShowAfterNewline :: forall m a. MonadAff m => Show a => a -> m Unit
uploadShowAfterNewline = uploadAfterNewline <<< show

uploadEmoji :: String
uploadEmoji = "⬆️ "

uploadPrefixed :: String -> Boolean -> Boolean -> String
uploadPrefixed msg short colorize = prefixed "upload" uploadColor uploadEmoji msg short colorize