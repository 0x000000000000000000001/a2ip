module Test.Util.Html.Index where

import Prelude

import Test.Spec (Spec)
import Test.Util.Html.Clean.Index as Clean
import Test.Util.Html.Encoding.Index as Encoding
import Test.Util.Html.Table.Index as Table

spec :: Spec Unit
spec = do
  Clean.spec
  Encoding.spec
  Table.spec