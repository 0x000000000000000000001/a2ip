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
import Effect.Console as Console

downloadColor :: Color
downloadColor = Cyan
 
downloadColorize :: String -> String
downloadColorize = colorize downloadColor

download :: ∀ m. MonadAff m => String -> m Unit
download = ʌ ◁ Console.log ◁ (\m -> downloadPrefixed m false false)

downloadAfterNewline :: ∀ m. MonadAff m => String -> m Unit
downloadAfterNewline msg = newline *> download msg

downloadShort :: ∀ m. MonadAff m => String -> m Unit
downloadShort = ʌ ◁ Console.log ◁ (\m -> downloadPrefixed m true false)

downloadShortAfterNewline :: ∀ m. MonadAff m => String -> m Unit
downloadShortAfterNewline msg = newline *> downloadShort msg

downloadShortShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
downloadShortShowAfterNewline = downloadShortAfterNewline ◁ show

downloadShortShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
downloadShortShow = downloadShort ◁ show

downloadShow :: ∀ m a. MonadAff m => Show a => a -> m Unit
downloadShow = download ◁ show

downloadShowAfterNewline :: ∀ m a. MonadAff m => Show a => a -> m Unit
downloadShowAfterNewline = downloadAfterNewline ◁ show

downloadEmoji :: String
downloadEmoji = "⬇️ "

downloadPrefixed :: String -> Boolean -> Boolean -> String
downloadPrefixed msg short colorize = prefixed "download" downloadColor downloadEmoji msg short colorize