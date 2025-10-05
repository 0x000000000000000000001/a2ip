module Test.Util.Html.Table where

import Prelude

import Test.Spec (Spec)
import Test.Util.Describe (describe)

import Test.Util.Html.Table.ExtractInnerCellsFromHtml as ExtractInnerCellsFromHtml
import Test.Util.Html.Table.ExtractInnerCellsFromRow as ExtractInnerCellsFromRow
import Test.Util.Html.Table.ExtractInnerColumnCellsFromHtml as ExtractInnerColumnCellsFromHtml
import Test.Util.Html.Table.ExtractInnerRowsFromHtml as ExtractInnerRowsFromHtml
import Test.Util.Html.Table.ExtractNextInnerCell as ExtractNextInnerCell
import Test.Util.Html.Table.ExtractTableFromHtml as ExtractTableFromHtml
import Test.Util.Html.Table.GetNextCellPos as GetNextCellPos

spec :: Spec Unit
spec = describe do
  ExtractInnerCellsFromHtml.spec
  ExtractInnerCellsFromRow.spec
  ExtractInnerColumnCellsFromHtml.spec
  ExtractInnerRowsFromHtml.spec
  ExtractNextInnerCell.spec
  ExtractTableFromHtml.spec
  GetNextCellPos.spec