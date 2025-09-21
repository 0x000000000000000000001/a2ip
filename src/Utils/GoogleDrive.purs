module Utils.GoogleDrive
  ( extractPortraitIdFromViewUrl
  , portraitViewUrlPrefix
  , portraitViewUrlSuffix
  )
  where

import Data.String (Pattern(..), split)

-- Google Drive Constants
portraitViewUrlPrefix :: String
portraitViewUrlPrefix = "https://drive.google.com/file/d/"

portraitViewUrlSuffix :: String
portraitViewUrlSuffix = "/view"

-- Extract Google Drive file ID from a view URL
extractPortraitIdFromViewUrl :: String -> String
extractPortraitIdFromViewUrl url =
  let
    withoutPrefix = case split (Pattern portraitViewUrlPrefix) url of
      [ _, rest ] -> rest
      _ -> url
    fileId = case split (Pattern portraitViewUrlSuffix) withoutPrefix of
      [ idPart, _ ] -> idPart
      _ -> withoutPrefix
  in
    fileId