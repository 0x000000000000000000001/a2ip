module Component.Page.About.HandleAction where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), Member, State, email, firstname, job, lastname, phone, portraitId, role)
import Data.Array (index, drop, findIndex) as Array
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), Replacement(..), drop, replace, split, take, trim)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error, error)
import Halogen as H

membersTabId :: String
membersTabId = "0"

commiteeTabId :: String
commiteeTabId = "2092489064"

googleSheetUrl :: String
googleSheetUrl = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE"

googleSheetCsvDownloadUrlTemplate :: String
googleSheetCsvDownloadUrlTemplate = googleSheetUrl <> "/export?format=csv&gid=..."

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
  LoadData -> do
    result <- H.liftAff $ fetchData

    case result of
      Left err -> log Error $ "Failed to load sheet data: " <> show err
      Right members_ -> H.modify_ _ { members = members_ }

fetchData :: forall m. MonadAff m => m (Either Error (Array (Maybe Member)))
fetchData = H.liftAff do
  result <- get string $ googleSheetCsvDownloadUrl membersTabId

  -- Debug
  -- pure $ Left $ error "Simulated error for testing"

  case result of
    Left err -> pure $ Left $ error $ "HTTP error: " <> AX.printError err
    Right response -> pure $ Right $ parseCsv response.body

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
    val key = trim $ getColByKey key mappingKeys cols
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

getColByKey :: String -> Array String -> Array String -> String
getColByKey key mappingKeys dataColumns =
  case Array.findIndex (_ == key) mappingKeys of
    Just index -> getCol index dataColumns
    Nothing -> ""

getCol :: Int -> Array String -> String
getCol pos arr = case Array.index arr pos of
  Just value -> trim value
  Nothing -> ""

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
