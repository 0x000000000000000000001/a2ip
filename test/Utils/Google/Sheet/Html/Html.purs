module Test.Utils.Google.Sheet.Html where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Describe (autoDescribeModule)
import Test.Utils.Google.Sheet.Html.ExtractTableFromHtml as ExtractTableFromHtml

spec :: Spec Unit
spec = autoDescribeModule do
  ExtractTableFromHtml.spec