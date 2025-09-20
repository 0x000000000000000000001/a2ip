module Component.Page.About.HandleAction
  ( handleAction
  )
  where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat (string, arrayBuffer)
import Affjax.Web (get)
import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), Member, State, email, firstname, job, lastname, phone, portraitId, role)
import Data.Array (index, drop, findIndex) as Array
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), Replacement(..), drop, replace, split, take, trim)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error, error)
import Halogen as H
import Utils.File.Unzip (unzipGoogleSheetAndExtractHtml)

tabIdToName :: String -> Maybe String
tabIdToName tabId 
  | tabId == membersTabId = Just membersTabName
  | tabId == commiteeTabId = Just commiteeTabName
  | otherwise = Nothing

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

googleSheetCsvDownloadUrlTemplate :: String
googleSheetCsvDownloadUrlTemplate = googleSheetUrl <> "/export?format=csv&gid=..."

googleSheetHtmlZipDownloadUrl :: String
googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"

googleSheetCsvDownloadUrl :: String -> String
googleSheetCsvDownloadUrl tabId = replace (Pattern "...") (Replacement tabId) googleSheetCsvDownloadUrlTemplate

portraitViewUrlPrefix :: String
portraitViewUrlPrefix = "https://drive.google.com/file/d/"

portraitViewUrlSuffix :: String
portraitViewUrlSuffix = "/view"

extractPortraitIdFromViewUrl :: String -> String
extractPortraitIdFromViewUrl url =
  let
    withoutPrefix = case split (Pattern portraitViewUrlPrefix) url of
      [ _, rest ] -> rest
      _ -> url
    id = case split (Pattern portraitViewUrlSuffix) withoutPrefix of
      [ idPart, _ ] -> idPart
      _ -> withoutPrefix
  in
    id

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadCsvData -> do
    result <- H.liftAff $ fetchCsvData

    case result of
      Left err -> log Error $ "Failed to load sheet data: " <> show err
      Right members_ -> H.modify_ _ { members = members_ }
  
  LoadHtmlData -> do
    result <- H.liftAff $ fetchHtmlZipData membersTabId
    
    case result of
      Left err -> log Error $ "Failed to load HTML data: " <> show err
      Right htmlContent -> log Info $ "HTML content loaded: " <> htmlContent

fetchCsvData :: forall m. MonadAff m => m (Either Error (Array (Maybe Member)))
fetchCsvData = H.liftAff do
  result <- get string $ googleSheetCsvDownloadUrl membersTabId

  -- Debug
  -- pure $ Left $ error $ "Simulated error for testing on: " <> googleSheetCsvDownloadUrl membersTabId

  case result of
    Left err -> pure $ Left $ error $ "HTTP error: " <> AX.printError err
    Right response -> pure $ Right $ parseCsv response.body

fetchHtmlZipData :: forall m. MonadAff m => String -> m (Either Error String)
fetchHtmlZipData tabId = H.liftAff do
  result <- get arrayBuffer googleSheetHtmlZipDownloadUrl

  -- Debug
  -- pure $ Left $ error $ "Simulated error for testing on: " <> googleSheetHtmlZipDownloadUrl

  case result of
    Left err -> pure $ Left $ error $ "HTTP error: " <> AX.printError err
    Right response -> do
      let tabName = fromMaybe "" $ tabIdToName tabId
      htmlContent <- unzipGoogleSheetAndExtractHtml tabName response.body
      
      -- Debug mode: return error with content for inspection
      -- pure $ Left $ error htmlContent

      -- Production mode: return the content
      pure $ Right htmlContent

parseCsv :: String -> Array (Maybe Member)
parseCsv csvText =
  let
    rows = split (Pattern "\n") $ trim csvText
    mappingRow = case Array.index rows 1 of
      Just row -> map trim $ parseCsvRow row -- Trim keys immediately
      Nothing -> []
    dataRows = Array.drop 2 rows
  in
    map (parseCsvRowWithMapping mappingRow) dataRows

parseCsvRowWithMapping :: Array String -> String -> Maybe Member
parseCsvRowWithMapping mappingKeys row =
  let
    cols = parseCsvRow row

    val key = trim $ colByKey key cols

    col :: Int -> Array String -> String
    col pos arr = case Array.index arr pos of
      Just value -> trim value
      Nothing -> ""

    colByKey :: String -> Array String -> String
    colByKey key dataColumns =
      case Array.findIndex (_ == key) mappingKeys of
        Just i -> col i dataColumns
        Nothing -> ""
  in
    Just
      { lastname: val lastname
      , firstname: val firstname 
      , role: val role
      , job: val job
      , email: val email
      , phone: val phone
      , portraitId: extractPortraitIdFromViewUrl $ val portraitId
      }

parseCsvRow :: String -> Array String
parseCsvRow row = parseCsvRow_ row [] "" false
  where
  parseCsvRow_ :: String -> Array String -> String -> Boolean -> Array String
  parseCsvRow_ "" fields currentField _ = fields <> [ trim currentField ]
  parseCsvRow_ str fields currentField inQuotes =
    let
      firstChar = take 1 str
      rest = drop 1 str
    in
      case firstChar of
        "\"" -> parseCsvRow_ rest fields currentField (not inQuotes)
        "," ->
          if inQuotes then parseCsvRow_ rest fields (currentField <> ",") inQuotes
          else parseCsvRow_ rest (fields <> [ trim currentField ]) "" false
        char -> parseCsvRow_ rest fields (currentField <> char) inQuotes
