module Test.Util.Google.Index where

import Prelude

import Test.Spec (Spec)
import Test.Util.Google.Drive.Index as Drive

spec :: Spec Unit
spec = do
  Drive.spec