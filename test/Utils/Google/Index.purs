module Test.Utils.Google.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Google.Drive.Index as Drive
import Test.Utils.Google.Sheet.Index as Sheet

spec :: Spec Unit
spec = do
  Drive.spec
  Sheet.spec 