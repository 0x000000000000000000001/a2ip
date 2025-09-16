module Component.Page.About.HandleAction where

import Prelude

import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), State)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (delay)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error)
import Halogen as H

googleSheetLink :: String
googleSheetLink = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE/edit?usp=sharing"

-- Sample data to simulate Google Sheets response
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
    H.modify_ _ { isLoading = true }
    
    -- Simulate API call delay
    H.liftAff $ delay (Milliseconds 1000.0)
    
    result <- H.liftAff $ fetchGoogleSheetData

    case result of
      Left err -> do
        log Error $ "Failed to load sheet data: " <> show err
      Right data_ -> do 
        log Info $ "Sheet data loaded successfully: " <> data_.title
        H.modify_ _ { isLoading = false, data = Just data_ } 
      
fetchGoogleSheetData :: forall m. MonadAff m => m (Either Error { title :: String, rows :: Array (Array String) })
fetchGoogleSheetData = H.liftAff do
  -- Simulate successful fetch with mock data
  pure $ Right mockData