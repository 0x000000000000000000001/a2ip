module Test.Utils.Html.Table.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Table.GetNextCellPos as GetNextCellPos
import Test.Utils.Html.Table.ExtractInnerCellsFromRow as ExtractInnerCellsFromRow
import Test.Utils.Html.Table.ExtractNextInnerCell as ExtractNextInnerCell
import Test.Utils.Html.Table.ExtractTableFromHtml as ExtractTableFromHtml
import Test.Utils.Html.Table.ExtractInnerRowsFromTable as ExtractInnerRowsFromTable

spec :: Spec Unit
spec = do 
  GetNextCellPos.spec
  ExtractInnerCellsFromRow.spec
  ExtractInnerRowsFromTable.spec
  ExtractNextInnerCell.spec 
  ExtractTableFromHtml.spec 