module Component.Page.About.HandleAction
  ( handleAction
  , extractMappingKeysAndValuesFromTable
  )
  where

import Prelude

import Affjax.Web (get)
import Capability.Log (class Log)
import Component.Page.About.Type (Action(..), Member, State, email, firstname, job, lastname, phone, portraitId, role)
import Data.Array (drop, fold, foldl, head, length, mapWithIndex, (!!))
import Data.Map (Map, empty, insert, lookup)
import Data.Maybe (Maybe(..), fromMaybe)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Utils.Html.Encode (arrayToIndexMap)
import Utils.Html.Table (extractInnerCellsFromHtml)

-- membersTabId :: String
-- membersTabId = "0"

-- membersTabName :: String
-- membersTabName = "Membres A2IP"

-- commiteeTabId :: String
-- commiteeTabId = "2092489064"

-- commiteeTabName :: String
-- commiteeTabName = "Comité international"

-- googleSheetUrl :: String
-- googleSheetUrl = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE"

-- googleSheetHtmlZipDownloadUrl :: String
-- googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"

-- tabIdToName :: String -> Maybe String
-- tabIdToName tabId 
--   | tabId == membersTabId = Just membersTabName
--   | tabId == commiteeTabId = Just commiteeTabName
--   | otherwise = Nothing

loadData :: forall o m. MonadAff m => Log m => H.HalogenM State Action () o m Unit
loadData = do
  pure unit
  -- result <- H.liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  -- case result of
  --   Left err -> log Error $ "Failed to fetch ZIP: " <> show err
  --   Right response -> do
  --     let tabName = fromMaybe "" $ tabIdToName membersTabId
  --     htmlContent <- H.liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
  --     members_ <- parseHtml htmlContent
  --     H.modify_ _ { members = members_ }

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadData -> loadData

type ExtractedData = { keys :: Array String , keyIndices :: Map String Int , values :: Array (Array String) }

convertExtractedDataToMembers :: ExtractedData -> Array Member
convertExtractedDataToMembers extractedData =
  let keys = extractedData.keys
      keyIndices = extractedData.keyIndices
      values = extractedData.values

      value :: String -> Array String -> String
      value key row =
        let idx = lookup key keyIndices
        in case idx of
          Just i -> fromMaybe "" $ row !! i 
          Nothing -> ""

      toMember :: Array String -> Member
      toMember row =
        { firstname: value firstname row
        , lastname: value lastname row
        , role: value role row
        , job: value job row
        , phone: value phone row
        , email: value email row
        , portraitId: value portraitId row
        }
  in map toMember values

-- | Extract mapping keys and values from an HTML table.
-- | The first row is treated as keys, subsequent rows as values.
-- |
-- | ```purescript
-- | >>> extractMappingKeysAndValuesFromTable "<table><tr><th>Name</th><th>Age</th></tr><tr><td>Alice</td><td>30</td></tr><tr><td>Bob</td><td>25</td></tr></table>"
-- | { keys: ["Name", "Age"], values: [["Alice", "30"], ["Bob", "25"]] }
-- | >>> extractMappingKeysAndValuesFromTable "<table><tr><td>Only cell</td></tr></table>"
-- | { keys: ["Only cell"], values: [] }
-- | >>> extractMappingKeysAndValuesFromTable "No table"
-- | { keys: [], values: [] }
-- | ```
extractMappingKeysAndValuesFromTable :: String -> ExtractedData
extractMappingKeysAndValuesFromTable tableHtml = 
  let nothing = { keys: [], keyIndices: empty, values: [] }
  in case extractInnerCellsFromHtml tableHtml of
    Nothing -> nothing
    Just cellArrays ->
      if length cellArrays == 0 
      then nothing
      else
        let keys = head cellArrays
            values = drop 1 cellArrays
        in { keys: fromMaybe [] keys, keyIndices: arrayToIndexMap (fromMaybe [] keys), values: values }
