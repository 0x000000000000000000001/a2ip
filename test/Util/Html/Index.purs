module Test.Util.Html.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Html.Clean.Index as Clean
import Test.Util.Html.Encode.Index as Encode
import Test.Util.Html.Table.Index as Table 

spec :: Spec Unit
spec = do
  Clean.spec
  Encode.spec
  Table.spec