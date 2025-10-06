module Util.File.Unzip where

import Prelude

import Control.Promise (Promise, toAff)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Effect.Aff (Aff)

foreign import _unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Promise String

unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Aff String
unzipGoogleSheetAndExtractHtml htmlFilename zipContent = 
  toAff $ _unzipGoogleSheetAndExtractHtml htmlFilename zipContent