module Test.Utils.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Google.Index as Google

spec :: Spec Unit
spec = do
  Google.spec 