module Component.Page.About.HandleAction
  ( ExtractedData
  , convertExtractedDataToMembers
  , extractMappingKeysAndValuesFromTableHtml
  , fetchMembersTableHtml
  , handleAction
  , loadMembers
  )
  where

import Prelude

import Affjax (get, printError)
import Affjax.ResponseFormat (arrayBuffer)
import Capability.AppM (AppM)
import Capability.Log (error)
import Component.Page.About.Type (Action(..), Member, State, email, firstname, job, lastname, phone, portraitId, role)
import Data.Array (drop, length, (!!))
import Data.Either (Either(..))
import Data.Map (Map, empty, lookup)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (trim)
import Effect.Aff.Class (class MonadAff)
import Halogen (HalogenM, liftAff, modify_)
import Util.Array.Map (arrayToIndexMap)
import Util.File.Unzip (unzipGoogleSheetAndExtractHtml)
import Util.Html.Table (extractInnerCellsFromHtml)

membersTabId :: String 
membersTabId = "0"

membersTabName :: String
membersTabName = "Membres A2IP"

commiteeTabId :: String
commiteeTabId = "2092489064"

commiteeTabName :: String
commiteeTabName = "Comité international"

googleSheetUrl :: String
googleSheetUrl = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE"

googleSheetHtmlZipDownloadUrl :: String
googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"

tabIdToName :: String -> Maybe String
tabIdToName tabId 
  | tabId == membersTabId = Just membersTabName
  | tabId == commiteeTabId = Just commiteeTabName
  | otherwise = Nothing

fetchMembersTableHtml :: forall m. MonadAff m => m (Either String String)
fetchMembersTableHtml = do
  result <- liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  case result of
    Left err -> pure $ Left $ "Failed to fetch ZIP: " <> printError err
    Right response -> do
      let tabName = fromMaybe "" $ tabIdToName membersTabId
      htmlContent <- liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
      pure $ Right htmlContent

loadMembers :: forall o. HalogenM State Action () o AppM Unit
loadMembers = do
  htmlContent <- liftAff $ fetchMembersTableHtml
  case htmlContent of
    Left err -> error err
    Right h -> do
      let extractedData = extractMappingKeysAndValuesFromTableHtml h
          members_ = convertExtractedDataToMembers extractedData
      modify_ _ { members = members_ }

handleAction :: forall o. Action -> HalogenM State Action () o AppM Unit
handleAction = case _ of
  LoadData -> loadMembers

type ExtractedData = { keys :: Array String , keyIndices :: Map String Int , values :: Array (Array String) }

convertExtractedDataToMembers :: ExtractedData -> Array (Maybe Member)
convertExtractedDataToMembers extractedData = 
  let keyIndices = extractedData.keyIndices
      values = extractedData.values

      value :: String -> Array String -> String
      value key row =
        let idx = lookup key keyIndices
        in case idx of
          Just i -> trim $ fromMaybe "" $ row !! i 
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

  in values <#> (Just <<< toMember)

-- | Extract mapping keys and values from a HTML table.
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
extractMappingKeysAndValuesFromTableHtml :: String -> ExtractedData
extractMappingKeysAndValuesFromTableHtml tableHtml = 
  let nothing = { keys: [], keyIndices: empty, values: [] }
  in case extractInnerCellsFromHtml tableHtml of
    Nothing -> nothing
    Just cellArrays ->
      if length cellArrays == 0 
      then nothing
      else
        let keys = cellArrays !! 1
            values = drop 3 cellArrays
        in { keys: fromMaybe [] keys, keyIndices: arrayToIndexMap (fromMaybe [] keys), values: values }
