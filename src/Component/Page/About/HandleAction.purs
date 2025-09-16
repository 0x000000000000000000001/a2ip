module Component.Page.About.HandleAction where

import Prelude

import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), State)
import Data.Array (length)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split, trim)
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (delay)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error, error)
import Halogen as H
import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Affjax.Web (driver)

-- Lien CSV de votre Google Sheet (format CSV export)
googleSheetCSVLink :: String
googleSheetCSVLink = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE/export?format=csv"

-- Sample data to simulate Google Sheets response (garde en backup)
mockData :: { title :: String, rows :: Array (Array String) }
mockData = 
  { title: "Sample Google Sheets Data"
  , rows: 
      [ ["Name", "Age", "City"]
      , ["Alice", "25", "Paris"] 
      , ["Bob", "30", "London"]
      , ["Charlie", "35", "New York"]
      ]
  }

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadSheetData -> do
    log Info "Starting to load Google Sheets data..."
    H.modify_ _ { isLoading = true, error = Nothing }
    
    -- Simulate API call delay
    H.liftAff $ delay (Milliseconds 1000.0)
    
    result <- H.liftAff $ fetchGoogleSheetData

    case result of
      Left err -> do
        let errorMsg = "Failed to load sheet data: " <> show err
        log Error errorMsg
        H.modify_ _ { isLoading = false, error = Just errorMsg }
        
      Right data_ -> do 
        log Info $ "Sheet data loaded successfully. Title: " <> data_.title <> ", Rows: " <> show (length data_.rows)
        H.modify_ _ { isLoading = false, data = Just data_, error = Nothing }

-- Fonction pour récupérer et parser le CSV depuis Google Sheets
fetchGoogleSheetData :: forall m. MonadAff m => m (Either Error { title :: String, rows :: Array (Array String) })
fetchGoogleSheetData = H.liftAff do
  -- Appel HTTP réel vers Google Sheets
  result <- AX.get driver ResponseFormat.string googleSheetCSVLink
  
  case result of
    Left err -> do
      -- Erreur réseau ou HTTP
      let errorMsg = "HTTP error: " <> AX.printError err
      pure $ Left $ error errorMsg
      
    Right response -> do
      -- Succès : parser le CSV
      let csvData = parseCSV response.body
      pure $ Right { title: "Google Sheets Data (Real CSV)", rows: csvData }

-- Parser CSV simple
parseCSV :: String -> Array (Array String)
parseCSV csvText = 
  map parseCSVRow $ split (Pattern "\n") $ trim csvText
  where
    parseCSVRow :: String -> Array String
    parseCSVRow row = map trim $ split (Pattern ",") row