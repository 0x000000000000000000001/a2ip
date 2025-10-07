module Util.File.Path
  ( assertDirRelativePath
  , assetDirAbsolutePath
  , imageDirAbsolutePath
  , imageDirRelativePath
  , ourAssetUrl
  , ourImageUrl
  , rootDirPath
  )
  where

import Prelude

foreign import rootDirPath :: String

assertDirRelativePath :: String
assertDirRelativePath = "/asset/"

assetDirAbsolutePath :: String
assetDirAbsolutePath = rootDirPath <> assertDirRelativePath

imageDirRelativePath :: String
imageDirRelativePath = assertDirRelativePath <> "image/"

imageDirAbsolutePath :: String
imageDirAbsolutePath = rootDirPath <> imageDirRelativePath

ourAssetUrl :: String -> String 
ourAssetUrl assetRelativePath = assertDirRelativePath <> assetRelativePath

ourImageUrl :: String -> String 
ourImageUrl imageRelativePath = imageDirRelativePath <> imageRelativePath

