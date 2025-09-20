module Utils.File.Unzip where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, makeAff, nonCanceler)
import Effect.Exception (Error)

foreign import unzipImpl :: String -> String -> (Error -> Effect Unit) -> (String -> Effect Unit) -> Effect Unit

unzipNExtractHtml :: String -> String -> Aff String
unzipNExtractHtml htmlFilename zipContent = makeAff \cb -> do
  unzipImpl htmlFilename zipContent 
    (\err -> cb (Left err))
    (\content -> cb (Right content))
  pure nonCanceler