module Test.Utils.Google.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Google.Drive.Index as Drive

spec :: Spec Unit
spec = do
  Drive.spec