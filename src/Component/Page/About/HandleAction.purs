module Component.Page.About.HandleAction
  ( ExtractedData
  , convertExtractedDataToMembers
  , extractMappingKeysAndValuesFromTableHtml
  , fetchMembers
  , fetchMembersTableHtml
  , googleDriveImageUrl
  , googleDriveImageUrlTemplate
  , googleDriveImageUrlTemplatePlaceholder
  , handleAction
  , mockImageUrl
  , mockImages
  , ourImageAbsolutePath
  , ourImageUrl
  , suffixPortraitIdWithExt
  )
  where

import Prelude

import Affjax (printError)
import Affjax.ResponseFormat (arrayBuffer)
import Bin.Util.Log.Error (error)
import Capability.AppM (AppM)
import Component.Page.About.Type (Action(..), Member, Slots, State, Output, email, firstname, job, lastname, phone, portraitId, role)
import Data.Array (drop, length, (!!))
import Data.Either (Either(..))
import Data.Map (Map, empty, lookup)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), Replacement(..), replace, trim)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (message)
import Halogen (HalogenM, liftAff, modify_)
import Util.Array.Map (arrayToIndexMap)
import Util.Condition ((?), (↔))
import Util.File.Path (imageDirAbsolutePath)
import Util.File.Unzip (unzipGoogleSheetAndExtractHtml)
import Util.GoogleDrive (extractPortraitIdFromViewUrl)
import Util.Html.Clean (untag)
import Util.Html.Table (extractInnerCellsFromHtml)
import Util.Http.Http (get)
import Util.Maybe ((??), (??⇒), (⇔))

mockImages :: Boolean
mockImages = true

googleDriveImageUrlTemplatePlaceholder :: String
googleDriveImageUrlTemplatePlaceholder = "__FILE_ID__"

googleDriveImageUrlTemplate :: String
googleDriveImageUrlTemplate = "https://www.googleapis.com/drive/v3/files/" <> googleDriveImageUrlTemplatePlaceholder <> "?alt=media&key=AIzaSyCe9sioL_5aL3-XrdFfU7AuavfhDZMnQeo"

googleDriveImageUrl :: String -> String
googleDriveImageUrl portraitId = replace (Pattern googleDriveImageUrlTemplatePlaceholder) (Replacement portraitId) googleDriveImageUrlTemplate

ourImageAbsolutePath :: String -> String
ourImageAbsolutePath portraitId = imageDirAbsolutePath <> "component/page/about/member/" <> suffixPortraitIdWithExt portraitId

ourImageUrl :: String -> String 
ourImageUrl portraitId = ourImageAbsolutePath portraitId

mockImageUrl :: String
mockImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/960px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg"

suffixPortraitIdWithExt :: String -> String
suffixPortraitIdWithExt id = id <> ".png"

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

fetchMembersTableHtml :: ∀ m. MonadAff m => m (Either String String)
fetchMembersTableHtml = do
  result <- liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  case result of
    Left e -> pure $ Left $ "Failed to fetch ZIP: " <> printError e
    Right response -> do
      let tabName = tabIdToName membersTabId ??⇒ ""
      htmlContent <- liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
      case htmlContent of
        Left e_ -> pure $ Left $ "Failed to unzip: " <> message e_
        Right h -> pure $ Right h

fetchMembers :: ∀ m. MonadAff m => m (Either String (Array (Maybe Member)))
fetchMembers = do
  htmlContent <- fetchMembersTableHtml
  case htmlContent of
    Left e -> pure $ Left e
    Right h -> do
      let extractedData = extractMappingKeysAndValuesFromTableHtml h
      pure $ Right $ convertExtractedDataToMembers extractedData

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  LoadData -> do
    members_ <- fetchMembers
    case members_ of
      Left e -> error $ "Error fetching members: " <> e
      Right m -> modify_ _ { members = m }

type ExtractedData = { keys :: Array String , keyIndices :: Map String Int , values :: Array (Array String) }

convertExtractedDataToMembers :: ExtractedData -> Array (Maybe Member)
convertExtractedDataToMembers extractedData = 
  let keyIndices = extractedData.keyIndices
      values = extractedData.values

      value :: String -> Array String -> String
      value key row =
        let idx = lookup key keyIndices
        in case idx of
          Just i -> trim $ row !! i ??⇒ ""
          Nothing -> ""

      toMember :: Array String -> Member
      toMember row =
        let portraitId_ = extractPortraitIdFromViewUrl $ untag $ value portraitId row :: Maybe String
        in 
          { firstname: value firstname row
          , lastname: value lastname row
          , role: value role row
          , job: value job row
          , phone: value phone row
          , email: value email row
          , portraitId: portraitId_ ??⇒ ""
          , originalPortraitUrl: portraitId_ ?? googleDriveImageUrl ⇔ ""
          , finalPortraitUrl: portraitId_ ?? ourImageUrl ⇔ ""
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
      length cellArrays == 0 
        ? nothing
        ↔ let keys = cellArrays !! 1
              values = drop 3 cellArrays
          in { keys: keys ??⇒ [], keyIndices: arrayToIndexMap $ keys ??⇒ [], values: values }
