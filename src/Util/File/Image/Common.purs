module Util.File.Image.Common where

import Proem

import Util.Capability.ReadConfig (class ReadConfig, readConfig)
import Data.String (Pattern(..), Replacement(..), replace)
import Util.File.Path (imageDirRelativePath)

mockImages :: Boolean
mockImages = true

googleDriveImageUrlTemplatePlaceholder :: String
googleDriveImageUrlTemplatePlaceholder = "__FILE_ID__"

googleDriveImageUrlTemplate :: String -> String
googleDriveImageUrlTemplate apiKey = "https://www.googleapis.com/drive/v3/files/" <> googleDriveImageUrlTemplatePlaceholder <> "?alt=media&key=" <> apiKey

googleDriveImageUrl :: ∀ m. ReadConfig m => String -> m String
googleDriveImageUrl id = do 
  config <- readConfig
  let apiKey = config.googleDriveApiKey
  η $ replace 
    (Pattern googleDriveImageUrlTemplatePlaceholder) 
    (Replacement id) 
    (googleDriveImageUrlTemplate apiKey)

ourImageRelativePath :: String -> String -> String
ourImageRelativePath path id = imageDirRelativePath <> path <> "/" <> suffixWithExt id

mockImageUrl :: String
mockImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/960px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg"

suffixWithExt :: String -> String
suffixWithExt id = id <> ".png"