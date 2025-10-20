module Test.Util.String.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.String.PadLeft as PadLeft
import Test.Util.String.PadRight as PadRight
import Test.Util.String.Slugify as Slugify

spec :: Spec Unit
spec = do
  PadLeft.spec
  PadRight.spec
  Slugify.spec
