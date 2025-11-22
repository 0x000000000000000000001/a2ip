module Util.File.Unzip where

import Proem

import Control.Promise (Promise, toAff)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Either (Either)
import Effect.Aff (Aff, attempt)
import Effect.Exception (Error)

foreign import _unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Promise String

foreign import _unzipToDirectory :: String -> ArrayBuffer -> Promise Unit

unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Aff (Either Error String)
unzipGoogleSheetAndExtractHtml htmlFilename zipContent = 
  attempt $ toAff $ _unzipGoogleSheetAndExtractHtml htmlFilename zipContent

unzipToDirectory :: String -> ArrayBuffer -> Aff (Either Error Unit)
unzipToDirectory outputDir zipContent =
  attempt $ toAff $ _unzipToDirectory outputDir zipContent
