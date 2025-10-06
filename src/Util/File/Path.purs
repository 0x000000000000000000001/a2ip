module Util.File.Path
  ( assertDirRelativePath
  , assetDirPath
  , imageDirPath
  , imageDirRelativePath
  , rootDirPath
  )
  where

import Prelude

foreign import rootDirPath :: String

assertDirRelativePath :: String
assertDirRelativePath = "/asset"

assetDirPath :: String
assetDirPath = rootDirPath <> assertDirRelativePath

imageDirRelativePath :: String
imageDirRelativePath = assertDirRelativePath <> "/image"

imageDirPath :: String
imageDirPath = rootDirPath <> imageDirRelativePath

