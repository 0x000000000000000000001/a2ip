module Test.Utils.Google.Sheet.Html where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.Describe.Module.Here (here)
import Test.Utils.Google.Sheet.Html.ExtractTableFromHtml as ExtractTableFromHtml

spec :: Spec Unit
spec = here do
  ExtractTableFromHtml.spec