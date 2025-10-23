module Test.Util.Google.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Google.Drive.Index as Drive
import Test.Util.Google.Sheet.Index as Sheet

spec :: Spec Unit
spec = do
  Drive.spec
  Sheet.spec