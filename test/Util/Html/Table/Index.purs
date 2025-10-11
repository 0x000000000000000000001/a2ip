module Test.Util.Html.Table.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Html.Table.GetNextCellPos as GetNextCellPos
import Test.Util.Html.Table.ExtractInnerCellsFromHtml as ExtractInnerCellsFromHtml
import Test.Util.Html.Table.ExtractInnerCellsFromRow as ExtractInnerCellsFromRow
import Test.Util.Html.Table.ExtractInnerRowsFromHtml as ExtractInnerRowsFromHtml
import Test.Util.Html.Table.ExtractNextInnerCell as ExtractNextInnerCell
import Test.Util.Html.Table.ExtractTableFromHtml as ExtractTableFromHtml

spec :: Spec Unit
spec = do 
  GetNextCellPos.spec
  ExtractInnerCellsFromHtml.spec
  ExtractInnerCellsFromRow.spec
  ExtractInnerRowsFromHtml.spec
  ExtractNextInnerCell.spec 
  ExtractTableFromHtml.spec 