module Utils.File.Unzip where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, makeAff, nonCanceler)
import Effect.Exception (Error)

import Data.ArrayBuffer.Types (ArrayBuffer)

foreign import _unzip :: String -> ArrayBuffer -> (Error -> Effect Unit) -> (String -> Effect Unit) -> Effect Unit

unzipGoogleSheetAndExtractHtml :: String -> ArrayBuffer -> Aff String
unzipGoogleSheetAndExtractHtml htmlFilename zipContent = makeAff \cb -> do
  _unzip htmlFilename zipContent 
    (\err -> cb $ Left err)
    (\content -> cb $ Right content)
  pure nonCanceler