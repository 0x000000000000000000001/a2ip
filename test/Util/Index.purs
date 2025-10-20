module Test.Util.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Google.Index as Google
import Test.Util.Html.Index as Html
import Test.Util.String.Index as String

spec :: Spec Unit
spec = do
  Google.spec
  Html.spec
  String.spec  