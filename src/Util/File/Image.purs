module Util.File.Image where

import Proem

import Affjax.ResponseFormat (arrayBuffer)
import Data.Either (Either(..))
import Data.String (Pattern(..), Replacement(..), replace)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Buffer (fromArrayBuffer)
import Node.FS.Aff (writeFile)
import Util.File.Path (imageDirRelativePath)
import Util.Http.Http (getCheckStatus)

-- | Downloads an image from the given URL and saves it to the specified file path.
-- | Returns an error message if the download fails.
-- | Returns Right Unit on success, Left String on failure.
downloadImage :: String -> String -> Aff (Either String Unit)
downloadImage url filePath = do
  response <- getCheckStatus arrayBuffer url
  response
    ?! (\res -> do
      buffer <- liftEffect $ fromArrayBuffer res.body
      writeFile filePath buffer
      Right ι # η
    )
    ⇿ (η ◁ Left)

mockImages :: Boolean
mockImages = true

googleDriveImageUrlTemplatePlaceholder :: String
googleDriveImageUrlTemplatePlaceholder = "__FILE_ID__"

googleDriveImageUrlTemplate :: String
googleDriveImageUrlTemplate = "https://www.googleapis.com/drive/v3/files/" <> googleDriveImageUrlTemplatePlaceholder <> "?alt=media&key=AIzaSyCe9sioL_5aL3-XrdFfU7AuavfhDZMnQeo"

googleDriveImageUrl :: String -> String
googleDriveImageUrl portraitId = replace (Pattern googleDriveImageUrlTemplatePlaceholder) (Replacement portraitId) googleDriveImageUrlTemplate

ourImageRelativePath :: String -> String
ourImageRelativePath portraitId = imageDirRelativePath <> "component/page/about/person/" <> suffixPortraitIdWithExt portraitId

mockImageUrl :: String
mockImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/960px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg"

suffixPortraitIdWithExt :: String -> String
suffixPortraitIdWithExt id = id <> ".png"