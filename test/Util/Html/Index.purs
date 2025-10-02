module Test.Utils.Html.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Clean.Index as Clean
import Test.Utils.Html.Encoding.Index as Encoding
import Test.Utils.Html.Table.Index as Table

spec :: Spec Unit
spec = do
  Clean.spec
  Encoding.spec
  Table.spec