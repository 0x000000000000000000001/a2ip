module Util.File.Path
  ( assertDirRelativePath
  , assetDirAbsolutePath
  , imageDirAbsolutePath
  , imageDirRelativePath
  , ourAssetUrl
  , ourImageUrl
  , outputDirAbsolutePath
  , outputDirRelativePath
  , rootDirAbsolutePath
  )
  where

import Proem

foreign import rootDirAbsolutePath :: String

assertDirRelativePath :: String
assertDirRelativePath = "asset/"

assetDirAbsolutePath :: String
assetDirAbsolutePath = rootDirAbsolutePath <> assertDirRelativePath

imageDirRelativePath :: String
imageDirRelativePath = assertDirRelativePath <> "image/"

imageDirAbsolutePath :: String
imageDirAbsolutePath = rootDirAbsolutePath <> imageDirRelativePath

ourAssetUrl :: String -> String 
ourAssetUrl assetRelativePath = assertDirRelativePath <> assetRelativePath

ourImageUrl :: String -> String 
ourImageUrl imageRelativePath = imageDirRelativePath <> imageRelativePath

outputDirRelativePath :: String
outputDirRelativePath = "output/"

outputDirAbsolutePath :: String 
outputDirAbsolutePath = rootDirAbsolutePath <> outputDirRelativePath
