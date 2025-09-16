module Component.Page.About.HandleAction where

import Prelude

import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), State)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error)
import Halogen as H
import Data.Either (Either(..))
import Effect.Aff (delay)
import Data.Time.Duration (Milliseconds(..))

-- Sample data to simulate Google Sheets response
sampleSheetData :: { title :: String, rows :: Array (Array String) }
sampleSheetData = 
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
  Initialize -> do
    log Info "About component initialized"
    handleAction LoadSheetData
    
  LoadSheetData -> do
    log Info "Loading Google Sheets data..."
    H.modify_ _ { isLoading = true, error = Nothing }
    
    -- Simulate API call delay
    H.liftAff $ delay (Milliseconds 1000.0)
    
    -- For now, use sample data (later we'll add real HTTP calls)
    result <- H.liftAff $ fetchGoogleSheet
    case result of
      Left err -> handleAction (SheetDataFailed err)
      Right sheetData -> handleAction (SheetDataLoaded sheetData)
      
  SheetDataLoaded sheetData -> do
    log Info $ "Sheet data loaded successfully: " <> sheetData.title
    H.modify_ _ 
      { isLoading = false
      , sheetData = Just sheetData
      , error = Nothing
      }
      
  SheetDataFailed err -> do
    let errorMsg = show err
    log Error $ "Failed to load sheet data: " <> errorMsg
    H.modify_ _ 
      { isLoading = false
      , sheetData = Nothing
      , error = Just errorMsg
      }

-- Function to simulate Google Sheets API call
-- TODO: Replace with real HTTP call when affjax is available
fetchGoogleSheet :: forall m. MonadAff m => m (Either Error { title :: String, rows :: Array (Array String) })
fetchGoogleSheet = H.liftAff do
  -- Simulate potential error (uncomment to test error handling)
  -- pure $ Left (error "Simulated API error")
  
  -- Return sample data
  pure $ Right sampleSheetData