module Test.Utils.Html.Table.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Table.GetNextCellPos as GetNextCellPos
import Test.Utils.Html.Table.ExtractInnerCellsFromHtml as ExtractInnerCellsFromHtml
import Test.Utils.Html.Table.ExtractInnerCellsFromRow as ExtractInnerCellsFromRow
import Test.Utils.Html.Table.ExtractInnerRowsFromHtml as ExtractInnerRowsFromHtml
import Test.Utils.Html.Table.ExtractNextInnerCell as ExtractNextInnerCell
import Test.Utils.Html.Table.ExtractTableFromHtml as ExtractTableFromHtml

spec :: Spec Unit
spec = do 
  GetNextCellPos.spec
  ExtractInnerCellsFromHtml.spec
  ExtractInnerCellsFromRow.spec
  ExtractInnerRowsFromHtml.spec
  ExtractNextInnerCell.spec 
  ExtractTableFromHtml.spec 