module Utils.GoogleDrive
  ( extractPortraitIdFromViewUrl
  , portraitViewUrlPrefix
  , portraitViewUrlSuffix
  )
  where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split)

portraitViewUrlPrefix :: String
portraitViewUrlPrefix = "https://drive.google.com/file/d/"

portraitViewUrlSuffix :: String
portraitViewUrlSuffix = "/view"

-- | Extracts the Google Drive file ID from a portrait view URL.
-- |
-- | Examples:
-- | ```purescript
-- | >>> extractPortraitIdFromViewUrl "https://drive.google.com/file/d/1A2B3C4D5E6F7G8H9I0J/view"
-- | Just "1A2B3C4D5E6F7G8H9I0J"
-- | >>> extractPortraitIdFromViewUrl "https://drive.google.com/file/d//view"
-- | Nothing
-- | >>> extractPortraitIdFromViewUrl "https://example.com/file/d/1A2B3C4D5E6F7G8H9I0J/view"
-- | Nothing
-- | ```
extractPortraitIdFromViewUrl :: String -> Maybe String
extractPortraitIdFromViewUrl url =
  let
    hasPrefix = case split (Pattern portraitViewUrlPrefix) url of
      [ _, _ ] -> true
      _ -> false
    
    withoutPrefix = case split (Pattern portraitViewUrlPrefix) url of
      [ _, rest ] -> rest
      _ -> url
      
    fileId = case split (Pattern portraitViewUrlSuffix) withoutPrefix of
      [ idPart, _ ] -> idPart
      _ -> withoutPrefix
  in
    if not hasPrefix
    then Nothing 
    else if fileId == ""
    then Nothing
    else Just fileId
  