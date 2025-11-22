module Util.Google.Sheet
  ( CellExtractor
  , Converter
  , ExtractedData
  , Tab
  , TabId
  , TableRow
  , convertExtractedData
  , extractMappingKeysAndValuesFromTableHtml
  , fetch
  , fetchTableHtml
  , googleSheetHtmlZipDownloadUrl
  , googleSheetUrl
  , tab
  )
  where

import Proem

import Affjax (printError)
import Affjax.ResponseFormat (string)
import Data.Array (drop, length, (!!))
import Data.Either (Either(..))
import Data.Map (Map, empty, lookup)
import Data.String (trim)
import Data.Symbol (class IsSymbol)
import Effect.Aff.Class (class MonadAff)
import Type.Prelude (Proxy)
import Util.Array.Map (arrayToIndexMap)
import Util.File.Path (assetDirAbsolutePath)
import Util.Html.Table (extractInnerCellsFromHtml)
import Util.Http.Http (get)
import Util.Proxy.Dictionary.Collaborators (collaborators_)
import Util.Proxy.Dictionary.Members (members_)
import Util.Proxy.Dictionary.Persons (persons_)

type ExtractedData = { keys :: Array String, keyIndices :: Map String Int, values :: Array (Array String) }

type TabId = String

type TableRow = Array String

type CellExtractor = ∀ sym. IsSymbol sym => Proxy sym -> TableRow -> String

type Converter output = (CellExtractor -> TableRow -> output)

type Tab = { id :: TabId, name :: String }

tab :: ∀ sym. IsSymbol sym => Proxy sym -> Tab 
tab p = 
  let p_ = ᴠ p 
      ans 
        | persons_ == p_ = { id: "261799651", name: "Personnes" }
        | members_ == p_ = { id: "0", name: "Membres A2IP" }
        | collaborators_ == p_ = { id: "2092489064", name: "Comité international" }
        | otherwise = { id: "1531940447", name: "Séminaires.Dates" }
  in ans

googleSheetUrl :: String
googleSheetUrl = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE"

googleSheetHtmlZipDownloadUrl :: String
googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"

fetchTableHtml :: ∀ m. MonadAff m => Tab -> m (Either String String)
fetchTableHtml tab_ = do
  result <- ʌ' $ get string (assetDirAbsolutePath <> "sheet/" <> tab_.name <> ".html")
  result
    ?! (η ◁ Right ◁ _.body)
    ⇿ \e -> η $ Left $ "Failed to fetch ZIP: " <> printError e

fetch :: ∀ sym m o. IsSymbol sym => MonadAff m => Proxy sym -> Converter o -> m (Either String (Array o))
fetch tabProxy to = do
  htmlContent <- fetchTableHtml (tab tabProxy)
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

    get :: CellExtractor
    get key row =
      let
        idx = lookup (ᴠ key) keyIndices
      in
        idx ?? (\i -> trim $ row !! i ??⇒ "") ⇔ ""

  in
    values <#> (to get)

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