module Util.File.Image where

import Prelude

import Affjax.ResponseFormat (arrayBuffer)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Buffer (fromArrayBuffer)
import Node.FS.Aff (writeFile)
import Util.Http.Http (getCheckStatus)

-- | Downloads an image from the given URL and saves it to the specified file path.
-- | Returns an error message if the download fails.
-- | Returns Right Unit on success, Left String on failure.
downloadImage :: String -> String -> Aff (Either String Unit)
downloadImage url filePath = do
  response <- getCheckStatus arrayBuffer url
  case response of
    Left error -> pure $ Left error
    Right res -> do
      buffer <- liftEffect $ fromArrayBuffer res.body
      writeFile filePath buffer
      pure $ Right unit