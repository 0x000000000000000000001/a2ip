module Bin.Util.Log.Download
  ( download
  , downloadAfterNewline
  , downloadColor
  , downloadColorize
  , downloadEmoji
  , downloadPrefixed
  , downloadShort
  , downloadShortAfterNewline
  , downloadShortShow
  , downloadShortShowAfterNewline
  , downloadShow
  , downloadShowAfterNewline
  )
  where

import Proem

import Ansi.Codes (Color(..))
import Bin.Util.Log.Log (colorize, newline, prefixed)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

downloadColor :: Color
downloadColor = Cyan
 
downloadColorize :: String -> String
downloadColorize = colorize downloadColor

download :: forall m. MonadAff m => String -> m Unit
download = liftEffect <<< Console.log <<< (\m -> downloadPrefixed m false false)

downloadAfterNewline :: forall m. MonadAff m => String -> m Unit
downloadAfterNewline msg = newline *> download msg

downloadShort :: forall m. MonadAff m => String -> m Unit
downloadShort = liftEffect <<< Console.log <<< (\m -> downloadPrefixed m true false)

downloadShortAfterNewline :: forall m. MonadAff m => String -> m Unit
downloadShortAfterNewline msg = newline *> downloadShort msg

downloadShortShowAfterNewline :: forall m a. MonadAff m => Show a => a -> m Unit
downloadShortShowAfterNewline = downloadShortAfterNewline <<< show

downloadShortShow :: forall m a. MonadAff m => Show a => a -> m Unit
downloadShortShow = downloadShort <<< show

downloadShow :: forall m a. MonadAff m => Show a => a -> m Unit
downloadShow = download <<< show

downloadShowAfterNewline :: forall m a. MonadAff m => Show a => a -> m Unit
downloadShowAfterNewline = downloadAfterNewline <<< show

downloadEmoji :: String
downloadEmoji = "⬇️ "

downloadPrefixed :: String -> Boolean -> Boolean -> String
downloadPrefixed msg short colorize = prefixed "download" downloadColor downloadEmoji msg short colorize