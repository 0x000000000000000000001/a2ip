module Test.Utils.Google.Sheet.Html.Index where

import Prelude

import Test.Spec (Spec)
-- import Test.Utils.Google.Sheet.Html.ExtractCellsFromRow as ExtractCellsFromRow
import Test.Utils.Google.Sheet.Html.ExtractNextCell as ExtractNextCell
import Test.Utils.Google.Sheet.Html.GetNextCellPos as GetNextCellPos
import Test.Utils.Google.Sheet.Html.ExtractTableFromHtml as ExtractTableFromHtml
import Test.Utils.Google.Sheet.Html.ExtractTableRows as ExtractTableRows

spec :: Spec Unit
spec = do
  -- ExtractCellsFromRow.spec
  ExtractNextCell.spec
  GetNextCellPos.spec
  ExtractTableFromHtml.spec
  ExtractTableRows.spec 