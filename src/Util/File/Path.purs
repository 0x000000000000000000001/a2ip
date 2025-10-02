module Util.File.Path
  ( assetDirPath
  , imageDirPath
  , rootDirPath
  )
  where

import Prelude

foreign import rootDirPath :: String

assetDirPath :: String
assetDirPath = rootDirPath <> "asset/"

imageDirPath :: String
imageDirPath = assetDirPath <> "image/"

