module Util.File.Image.Common where

import Proem

import Data.String (Pattern(..), Replacement(..), replace)
import Util.File.Path (imageDirRelativePath)

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