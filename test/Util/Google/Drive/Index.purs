module Test.Util.Google.Drive.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Google.Drive.ExtractPortraitIdFromViewUrl as ExtractPortraitIdFromViewUrl

spec :: Spec Unit
spec = do
  ExtractPortraitIdFromViewUrl.spec