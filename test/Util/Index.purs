module Test.Utils.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Google.Index as Google
import Test.Utils.Html.Index as Html

spec :: Spec Unit
spec = do
  Google.spec
  Html.spec 