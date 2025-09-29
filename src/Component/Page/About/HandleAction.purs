module Component.Page.About.HandleAction
  ( handleAction
  )
  where

import Prelude

import Capability.Log (class Log)
import Component.Page.About.Type (Action(..), State)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H

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

loadData :: forall o m. MonadAff m => Log m => H.HalogenM State Action () o m Unit
loadData = do
  pure unit
  -- result <- H.liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  -- case result of
  --   Left err -> log Error $ "Failed to fetch ZIP: " <> show err
  --   Right response -> do
        -- let tabName = fromMaybe "" $ tabIdToName tabId
--   htmlContent <- H.liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
  --     members_ <- parseHtml htmlContent
  --     H.modify_ _ { members = members_ }

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadData -> loadData 

extractMappingKeysAndValuesFromTable :: String -> { keys :: Array String , values :: Array (Array String) }
extractMappingKeysAndValuesFromTable tableHtml = { keys: [], values: [] }
