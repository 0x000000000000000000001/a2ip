module Test.Utils.Google.Sheet.Html where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Describe (autoDescribe)
import Test.Utils.Google.Sheet.Html.ExtractTableFromHtml as ExtractTableFromHtmlTests

spec :: Spec Unit
spec = autoDescribe do
  ExtractTableFromHtmlTests.spec