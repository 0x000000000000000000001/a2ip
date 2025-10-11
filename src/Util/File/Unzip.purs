module Util.File.Unzip where

import Proem

import Control.Promise (Promise, toAff)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Either (Either)
import Effect.Aff (Aff, attempt)
import Effect.Exception (Error)

foreign import _unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Promise String

unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Aff (Either Error String)
unzipGoogleSheetAndExtractHtml htmlFilename zipContent = 
  attempt $ toAff $ _unzipGoogleSheetAndExtractHtml htmlFilename zipContent