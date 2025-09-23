module Test.Utils.Google.Sheet.Html.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Google.Sheet.Html.ExtractTableFromHtml as ExtractTableFromHtml
import Test.Utils.Google.Sheet.Html.ExtractTableRows as ExtractTableRows

spec :: Spec Unit
spec = do
  ExtractTableFromHtml.spec
  ExtractTableRows.spec