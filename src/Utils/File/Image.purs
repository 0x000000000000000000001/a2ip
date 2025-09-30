module Utils.File.Image where

import Prelude

import Affjax.Node (get, printError)
import Affjax.ResponseFormat (arrayBuffer)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Node.Buffer (fromArrayBuffer)
import Node.FS.Aff (writeFile)

downloadImage :: String -> String -> Aff Unit
downloadImage url filePath = do
  response <- get arrayBuffer url
  case response of
    Left error -> liftEffect $ log $ "aie aie aie: " <> printError error
    Right res -> do
      buffer <- liftEffect $ fromArrayBuffer res.body
      writeFile filePath buffer
      liftEffect $ log $ "✅ Downloaded: " <> filePath