module Component.Page.About.HandleAction
  ( handleAction
  )
  where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat (arrayBuffer)
import Affjax.Web (get)
import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), Member, State)
import Data.Array (length, mapMaybe, range, take) as Array
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Either (Either(..))

import Data.Maybe (Maybe(..), fromMaybe)

import Effect.Aff.Class (class MonadAff)

import Halogen as H
import Utils.File.Unzip (unzipGoogleSheetAndExtractHtml)
import Utils.GoogleDrive (extractPortraitIdFromViewUrl)
import Utils.Google.Sheet.Html (extractMappingKeysFromTable, extractRowCells, getValueByKey)

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

dataStartRowIndex :: Int
dataStartRowIndex = 4

maxDataRows :: Int
maxDataRows = 6

maxColumns :: Int
maxColumns = 7

tabIdToName :: String -> Maybe String
tabIdToName tabId 
  | tabId == membersTabId = Just membersTabName
  | tabId == commiteeTabId = Just commiteeTabName
  | otherwise = Nothing

headerToMappingKey :: String -> String
headerToMappingKey = case _ of
  "Prénom" -> "firstname"
  "Nom" -> "lastname" 
  "Fonction A2IP" -> "role"
  "Profession" -> "job"
  "Email" -> "email"
  "Numéro de tél" -> "phone"
  "Lien ou ID du portrait" -> "portraitId"
  _ -> "unknown" 

logError :: forall m. Log m => String -> m Unit
logError message = log Error message

updateMembersState :: forall o m. Array (Maybe Member) -> H.HalogenM State Action () o m Unit
updateMembersState members_ = H.modify_ _ { members = members_ }

fetchZipData :: forall m. MonadAff m => m (Either AX.Error (AX.Response ArrayBuffer))
fetchZipData = H.liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl

extractHtmlFromZip :: forall m. MonadAff m => String -> ArrayBuffer -> m String
extractHtmlFromZip tabName responseBody = H.liftAff $ unzipGoogleSheetAndExtractHtml tabName responseBody

processZipResponse :: forall m. MonadAff m => String -> AX.Response ArrayBuffer -> m (Array (Maybe Member))
processZipResponse tabId response = do
  let tabName = fromMaybe "" $ tabIdToName tabId
  htmlContent <- extractHtmlFromZip tabName response.body
  pure $ parseHtml htmlContent

handleLoadHtmlData :: forall o m. MonadAff m => Log m => H.HalogenM State Action () o m Unit
handleLoadHtmlData = do
  result <- fetchZipData
  case result of
    Left err -> logError $ "Failed to fetch ZIP: " <> AX.printError err
    Right response -> do
      members_ <- processZipResponse membersTabId response
      updateMembersState members_

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadHtmlData -> handleLoadHtmlData

createMemberFromRow :: Array String -> Array String -> Maybe Member
createMemberFromRow mappingKeys rowCells =
  let getValue = getValueByKey mappingKeys rowCells
  in Just
    { lastname: getValue "lastname"
    , firstname: getValue "firstname"
    , role: getValue "role"
    , job: getValue "job"
    , email: getValue "email"
    , phone: getValue "phone"
    , portraitId: fromMaybe "" $ extractPortraitIdFromViewUrl $ getValue "portraitId"
    }

parseHtmlRowWithMapping :: Array String -> Array String -> Maybe Member
parseHtmlRowWithMapping = createMemberFromRow

extractMappingKeysForAbout :: String -> Array String
extractMappingKeysForAbout = extractMappingKeysFromTable headerToMappingKey

extractDataRowsForAbout :: String -> Array (Array String)
extractDataRowsForAbout htmlContent =
  let rowIndexes = Array.range dataStartRowIndex (dataStartRowIndex + maxDataRows - 1)
      extractRowIfNotEmpty rowIndex =
        let allRowCells = extractRowCells htmlContent rowIndex
            rowCells = Array.take maxColumns allRowCells
        in if Array.length rowCells > 0 then Just rowCells else Nothing
  in Array.mapMaybe extractRowIfNotEmpty rowIndexes

parseHtml :: String -> Array (Maybe Member)
parseHtml htmlContent =
  let mappingKeys = extractMappingKeysForAbout htmlContent
      dataRows = extractDataRowsForAbout htmlContent
  in map (parseHtmlRowWithMapping mappingKeys) dataRows


