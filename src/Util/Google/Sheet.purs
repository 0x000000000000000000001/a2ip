module Util.Google.Sheet
  ( CellExtractor
  , Converter
  , ExtractedData
  , TabId
  , TableRow
  , collaboratorsTabId
  , collaboratorsTabName
  , convertExtractedData
  , extractMappingKeysAndValuesFromTableHtml
  , fetch
  , fetchTableHtml
  , googleSheetHtmlZipDownloadUrl
  , googleSheetUrl
  , membersTabId
  , membersTabName
  , tabIdToName
  )
  where

import Proem

import Affjax (printError)
import Affjax.ResponseFormat (arrayBuffer)
import Data.Array (drop, length, (!!))
import Data.Either (Either(..))
import Data.Map (Map, empty, lookup)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Data.Symbol (class IsSymbol)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (message)
import Halogen (liftAff)
import Type.Prelude (Proxy)
import Util.Array.Map (arrayToIndexMap)
import Util.File.Unzip (unzipGoogleSheetAndExtractHtml)
import Util.Html.Table (extractInnerCellsFromHtml)
import Util.Http.Http (get)

type ExtractedData = { keys :: Array String, keyIndices :: Map String Int, values :: Array (Array String) }

type TabId = String

type TableRow = Array String

type CellExtractor = ∀ sym. IsSymbol sym => Proxy sym -> TableRow -> String

type Converter output = (CellExtractor -> TableRow -> output)

membersTabId :: TabId
membersTabId = "0"

membersTabName :: String
membersTabName = "Membres A2IP"

collaboratorsTabId :: TabId
collaboratorsTabId = "2092489064"

collaboratorsTabName :: String
collaboratorsTabName = "Comité international"

tabIdToName :: TabId -> Maybe String
tabIdToName tabId
  | tabId == membersTabId = Just membersTabName
  | tabId == collaboratorsTabId = Just collaboratorsTabName
  | otherwise = Nothing

googleSheetUrl :: String
googleSheetUrl = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE"

googleSheetHtmlZipDownloadUrl :: String
googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"
  
fetchTableHtml :: ∀ m. MonadAff m => String -> m (Either String String)
fetchTableHtml tabId = do
  result <- liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  result
    ?!
      ( \response -> do
          let tabName = tabIdToName tabId ??⇒ ""
          htmlContent <- liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
          htmlContent
            ?! (η ◁ Right)
            ⇿ \e_ -> η $ Left $ "Failed to unzip: " <> message e_
      )
    ⇿ \e -> η $ Left $ "Failed to fetch ZIP: " <> printError e

fetch :: ∀ m o. MonadAff m => TabId -> Converter o -> m (Either String (Array o))
fetch tabId to = do
  htmlContent <- fetchTableHtml tabId
  htmlContent
    ?!
      ( \h -> do
          let extractedData = extractMappingKeysAndValuesFromTableHtml h
          η $ Right $ convertExtractedData to extractedData
      )
    ⇿ (η ◁ Left)

convertExtractedData :: ∀ o. Converter o -> ExtractedData -> Array o
convertExtractedData to extractedData =
  let
    keyIndices = extractedData.keyIndices
    values = extractedData.values

    getHtmlCell :: CellExtractor
    getHtmlCell key row =
      let
        idx = lookup (ᴠ key) keyIndices
      in
        idx ?? (\i -> trim $ row !! i ??⇒ "") ⇔ ""

  in
    values <#> (to getHtmlCell)

-- | Extract mapping keys and values from a HTML table.
-- | The first row is treated as keys, subsequent rows as values.
-- |
-- | ```purescript
-- | >>> extractMappingKeysAndValuesFromTable """
-- | <table>
-- |    <tr><th>A1</th><th>B1</th></tr>
-- |    <tr><td>name</td><td>age</td></tr>
-- |    <tr><td>Name (lastname is optional)</td><td>Age (plain digits)</td></tr>
---|    <tr><td>Alice</td><td>30</td></tr>
-- |    <tr><td>Bob</td><td>25</td></tr>
-- | </table>
-- | """
-- | { keys: ["name", "age"], ... values: [["Alice", "30"], ["Bob", "25"]] }
-- |
-- | >>> extractMappingKeysAndValuesFromTable "<table><tr><td>Only cell</td></tr></table>"
-- | { keys: [], ... values: [] }
-- |
-- | >>> extractMappingKeysAndValuesFromTable "No table"
-- | { keys: [], ... values: [] }
-- | ```
extractMappingKeysAndValuesFromTableHtml :: String -> ExtractedData
extractMappingKeysAndValuesFromTableHtml tableHtml =
  let
    nothing = { keys: [], keyIndices: empty, values: [] }
  in
    extractInnerCellsFromHtml tableHtml
      ??
        ( \cellArrays ->
            length cellArrays == 0
              ? nothing
              ↔
                let
                  keys = cellArrays !! 1 ??⇒ []
                  values = drop 3 cellArrays
                in
                  { keys, keyIndices: arrayToIndexMap keys, values: values }
        )
      ⇔ nothing