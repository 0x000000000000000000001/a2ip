module Test.Utils.Html.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Clean.Index as Clean
import Test.Utils.Html.Encoding.Index as Encoding

spec :: Spec Unit
spec = do
  Clean.spec
  Encoding.spec