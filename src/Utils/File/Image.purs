module Utils.File.Image where

import Prelude

import Affjax.ResponseFormat (arrayBuffer)
import Affjax.Web (get)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Buffer (fromArrayBuffer)
import Node.FS.Aff (writeFile)

downloadImage :: String -> String -> Aff Unit
downloadImage url filePath = do
  response <- get arrayBuffer url
  case response of
    Left _ -> pure unit
    Right res -> do
      buffer <- liftEffect $ fromArrayBuffer res.body
      writeFile filePath buffer