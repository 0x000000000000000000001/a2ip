module Test.Util.Google.Drive.Index where

import Prelude

import Test.Spec (Spec)
import Test.Util.Google.Drive.ExtractPortraitIdFromViewUrl as ExtractPortraitIdFromViewUrl

spec :: Spec Unit
spec = do
  ExtractPortraitIdFromViewUrl.spec