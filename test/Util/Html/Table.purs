module Test.Utils.Html.Table where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Describe (describe)

import Test.Utils.Html.Table.ExtractInnerCellsFromHtml as ExtractInnerCellsFromHtml
import Test.Utils.Html.Table.ExtractInnerCellsFromRow as ExtractInnerCellsFromRow
import Test.Utils.Html.Table.ExtractInnerRowsFromHtml as ExtractInnerRowsFromHtml
import Test.Utils.Html.Table.ExtractNextInnerCell as ExtractNextInnerCell
import Test.Utils.Html.Table.ExtractTableFromHtml as ExtractTableFromHtml
import Test.Utils.Html.Table.GetNextCellPos as GetNextCellPos

spec :: Spec Unit
spec = describe do
  ExtractInnerCellsFromHtml.spec
  ExtractInnerCellsFromRow.spec
  ExtractInnerRowsFromHtml.spec
  ExtractNextInnerCell.spec
  ExtractTableFromHtml.spec
  GetNextCellPos.spec