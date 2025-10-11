module Util.GoogleDrive
  ( extractPortraitIdFromViewUrl
  , portraitViewUrlPrefix
  , portraitViewUrlSuffix
  )
  where

import Proem
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
-- | >>> extractPortraitIdFromViewUrl "https://drive.google.com/file/d/1A2B3C4D5E6F7G8H9I0J/view?usp=sharing"
-- | Just "1A2B3C4D5E6F7G8H9I0J"
-- |
-- | >>> extractPortraitIdFromViewUrl "1A2B3C4D5E6F7G8H9I0J"
-- | Just "1A2B3C4D5E6F7G8H9I0J"
-- |
-- | >>> extractPortraitIdFromViewUrl "1A2B3C4D5E6F7G8H9I0J/view?usp=sharing"
-- | Just "1A2B3C4D5E6F7G8H9I0J"
-- |
-- | >>> extractPortraitIdFromViewUrl "https://drive.google.com/file/d//view"
-- | Nothing
-- |
-- | >>> extractPortraitIdFromViewUrl "https://example.com/file/d/1A2B3C4D5E6F7G8H9I0J/view"
-- | Nothing
-- | ```
extractPortraitIdFromViewUrl :: String -> Maybe String
extractPortraitIdFromViewUrl url =
  let
    hasPrefix = case split (Pattern portraitViewUrlPrefix) url of
      [ _, _ ] -> true
      _ -> false
    
    isHttpsOtherDomain = case split (Pattern "https://") url of
      [ "", rest ] -> not hasPrefix && rest /= ""
      _ -> false
    
    isHttpOtherDomain = case split (Pattern "http://") url of
      [ "", rest ] -> not hasPrefix && rest /= ""
      _ -> false
    
    isOtherDomain = isHttpsOtherDomain || isHttpOtherDomain
    
    withoutPrefix = case split (Pattern portraitViewUrlPrefix) url of
      [ _, rest ] -> rest
      _ -> url
      
    fileId = case split (Pattern portraitViewUrlSuffix) withoutPrefix of
      [ idPart, _ ] -> idPart
      _ -> withoutPrefix
  in
    if isOtherDomain
    then Nothing
    else if fileId == ""
    then Nothing
    else Just fileId
  