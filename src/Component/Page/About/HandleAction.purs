module Component.Page.About.HandleAction where

import Prelude

import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), State)
import Data.Array (length)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split, trim)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error, error)
import Halogen as H
import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Affjax.Web (driver)

googleSheetCsvLink :: String
googleSheetCsvLink = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE/export?format=csv"

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadSheetData -> do
    result <- H.liftAff $ fetchData

    case result of
      Left err -> do
        log Error $ "Failed to load sheet data: " <> show err
        
      Right data_ -> do 
        log Info $ "Sheet data loaded successfully. Title: " <> data_.title <> ", Rows: " <> show (length data_.rows)
        H.modify_ _ { isLoading = false, data = Just data_ }

fetchData :: forall m. MonadAff m => m (Either Error { title :: String, rows :: Array (Array String) })
fetchData = H.liftAff do
  result <- AX.get driver ResponseFormat.string googleSheetCsvLink
  
  case result of
    Left err -> do
      let errorMsg = "HTTP error: " <> AX.printError err
      pure $ Left $ error errorMsg
      
    Right response -> do
      let csvData = parseCSV response.body
      pure $ Right { title: "Google Sheets Data (Real CSV)", rows: csvData }

-- Parser CSV simple
parseCSV :: String -> Array (Array String)
parseCSV csvText = 
  map parseCSVRow $ split (Pattern "\n") $ trim csvText
  where
    parseCSVRow :: String -> Array String
    parseCSVRow row = map trim $ split (Pattern ",") row