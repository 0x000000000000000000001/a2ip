module Component.Page.About.HandleAction where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), State, Member)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Array (index, drop, findIndex) as Array
import Data.String (Pattern(..), split, trim, take, drop)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error, error)
import Halogen as H

googleSheetCsvLink :: String
googleSheetCsvLink = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE/export?format=csv"

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadData -> do
    result <- H.liftAff $ fetchData

    case result of
      Left err -> log Error $ "Failed to load sheet data: " <> show err
      Right data_ -> H.modify_ _ { isLoading = false, data = Just data_ }

fetchData :: forall m. MonadAff m => m (Either Error (Array Member))
fetchData = H.liftAff do
  result <- get string googleSheetCsvLink

  case result of
    Left err -> pure $ Left $ error $ "HTTP error: " <> AX.printError err
    Right response -> pure $ Right $ parseCsv response.body

parseCsv :: String -> Array Member
parseCsv csvText =
  let
    rows = split (Pattern "\n") $ trim csvText
    mappingRow = case Array.index rows 1 of
      Just row -> map trim $ parseCsvRow row -- Trim keys immediately
      Nothing -> []
    dataRows = Array.drop 2 rows
  in
    map (parseCsvRowWithMapping mappingRow) dataRows

parseCsvRowWithMapping :: Array String -> String -> Member
parseCsvRowWithMapping mappingKeys row =
  let
    cols = parseCsvRow row
    getValue key = getColByKey key mappingKeys cols
  in
    { lastname: getValue "lastname"
    , firstname: getValue "firstname"
    , role: getValue "role"
    , job: getValue "job"
    , email: getValue "email"
    , phone: getValue "phone"
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
  