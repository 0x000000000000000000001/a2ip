module Test.Utils.Google.Drive.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.Describe.Module.Here (here)
import Test.Utils.Google.Drive.ExtractPortraitIdFromViewUrl as ExtractPortraitIdFromViewUrl

spec :: Spec Unit
spec = here do
  ExtractPortraitIdFromViewUrl.spec