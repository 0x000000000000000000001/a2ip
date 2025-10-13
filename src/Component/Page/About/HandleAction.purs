module Component.Page.About.HandleAction
  ( ExtractedData
  , convertExtractedData
  , extractMappingKeysAndValuesFromTableHtml
  , fetch
  , fetchCollaborators
  , fetchMembers
  , googleDriveImageUrl
  , googleDriveImageUrlTemplate
  , googleDriveImageUrlTemplatePlaceholder
  , handleAction
  , mockImageUrl
  , mockImages
  , ourImageRelativePath
  , suffixPortraitIdWithExt
  , toCollaborator
  , toMember
  )
  where

import Proem

import Affjax (printError)
import Affjax.ResponseFormat (arrayBuffer)
import Capability.AppM (AppM)
import Capability.Log (error)
import Component.Page.About.Type (Action(..), Collaborator, Member, Output, Slots, State, country, email, firstname, job, lastname, phone, portraitId, role)
import Data.Array (drop, length, (!!))
import Data.Either (Either(..))
import Data.Map (Map, empty, lookup)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), Replacement(..), replace, trim)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (message)
import Halogen (HalogenM, liftAff, modify_)
import Util.Array.Map (arrayToIndexMap)
import Util.File.Path (imageDirRelativePath)
import Util.File.Unzip (unzipGoogleSheetAndExtractHtml)
import Util.GoogleDrive (extractPortraitIdFromViewUrl)
import Util.Html.Clean (untag)
import Util.Html.Table (extractInnerCellsFromHtml)
import Util.Http.Http (get)

type ExtractedData = { keys :: Array String , keyIndices :: Map String Int , values :: Array (Array String) }

type TabId = String

type Key = String

type TableRow = Array String

type CellExtractor = Key -> TableRow -> String

type Converter o = (CellExtractor -> TableRow -> o)

mockImages :: Boolean
mockImages = true

googleDriveImageUrlTemplatePlaceholder :: String
googleDriveImageUrlTemplatePlaceholder = "__FILE_ID__"

googleDriveImageUrlTemplate :: String
googleDriveImageUrlTemplate = "https://www.googleapis.com/drive/v3/files/" <> googleDriveImageUrlTemplatePlaceholder <> "?alt=media&key=AIzaSyCe9sioL_5aL3-XrdFfU7AuavfhDZMnQeo"

googleDriveImageUrl :: String -> String
googleDriveImageUrl portraitId = replace (Pattern googleDriveImageUrlTemplatePlaceholder) (Replacement portraitId) googleDriveImageUrlTemplate

ourImageRelativePath :: String -> String
ourImageRelativePath portraitId = imageDirRelativePath <> "component/page/about/member/" <> suffixPortraitIdWithExt portraitId

mockImageUrl :: String
mockImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/960px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg"

suffixPortraitIdWithExt :: String -> String
suffixPortraitIdWithExt id = id <> ".png"

membersTabId :: TabId 
membersTabId = "0"

membersTabName :: String
membersTabName = "Membres A2IP"

collaboratorsTabId :: TabId
collaboratorsTabId = "2092489064"

collaboratorsTabName :: String
collaboratorsTabName = "Comité international"

googleSheetUrl :: String
googleSheetUrl = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE"

googleSheetHtmlZipDownloadUrl :: String
googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"

tabIdToName :: TabId -> Maybe String
tabIdToName tabId 
  | tabId == membersTabId = Just membersTabName
  | tabId == collaboratorsTabId = Just collaboratorsTabName
  | otherwise = Nothing

fetchTableHtml :: ∀ m. MonadAff m => String -> m (Either String String)
fetchTableHtml tabId = do
  result <- liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  result 
    ?! (\response -> do
      let tabName = tabIdToName tabId ??⇒ ""
      htmlContent <- liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
      htmlContent 
        ?! pure ◁ Right
        ⇿ \e_ -> pure $ Left $ "Failed to unzip: " <> message e_
    )
    ⇿ \e -> pure $ Left $ "Failed to fetch ZIP: " <> printError e

fetch :: ∀ m o. MonadAff m => TabId -> Converter o -> m (Either String (Array o))
fetch tabId to = do
  htmlContent <- fetchTableHtml tabId
  htmlContent 
    ?! (\h -> do 
      let extractedData = extractMappingKeysAndValuesFromTableHtml h
      pure $ Right $ convertExtractedData to extractedData
    )
    ⇿ pure ◁ Left

fetchMembers :: ∀ m. MonadAff m => m (Either String (Array Member))
fetchMembers = fetch membersTabId toMember

fetchCollaborators :: ∀ m. MonadAff m => m (Either String (Array Collaborator))
fetchCollaborators = fetch collaboratorsTabId toCollaborator

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  Load -> do
    members <- fetchMembers
    members 
      ?! (\m -> modify_ _ { members = Just m })
      ⇿ error ◁ ("Error fetching members: " <> _)

    collaborators <- fetchCollaborators
    collaborators 
      ?! (\c -> modify_ _ { collaborators = Just c })
      ⇿ error ◁ ("Error fetching collaborators: " <> _)

convertExtractedData :: ∀ o. Converter o -> ExtractedData -> Array o
convertExtractedData to extractedData = 
  let keyIndices = extractedData.keyIndices
      values = extractedData.values

      getHtmlCell :: CellExtractor
      getHtmlCell key row =
        let idx = lookup key keyIndices
        in idx ?? (\i -> trim $ row !! i ??⇒ "") ⇔ ""

  in values <#> (to getHtmlCell)

toMember :: Converter Member
toMember getHtmlCell row =
  let portraitId_ = extractPortraitIdFromViewUrl $ untag $ getHtmlCell portraitId row :: Maybe String
  in 
    { firstname: getHtmlCell firstname row
    , lastname: getHtmlCell lastname row
    , role: getHtmlCell role row
    , job: getHtmlCell job row
    , phone: getHtmlCell phone row
    , email: getHtmlCell email row
    , portraitId: portraitId_ ??⇒ ""
    }

toCollaborator :: Converter Collaborator
toCollaborator getHtmlCell row =
  trim $ getHtmlCell firstname row <> " " <> getHtmlCell lastname row <> " (" <> getHtmlCell country row <> ")"

-- | Extract mapping keys and values from a HTML table.
-- | The first row is treated as keys, subsequent rows as values.
-- |
-- | ```purescript
-- | >>> extractMappingKeysAndValuesFromTable """
-- | <table>
-- |    <tr><th>A1</th><th>B1</th></tr>
-- |    <tr><td>name</td><td>age</td></tr>
-- |    <tr><td>Name (lastname is optional)</td><td>Age (plain digits)</td></tr>
---|    <tr><td>Alice</td><td>30</td></tr>
-- |    <tr><td>Bob</td><td>25</td></tr>
-- | </table>
-- | """
-- | { keys: ["name", "age"], ... values: [["Alice", "30"], ["Bob", "25"]] }
-- |
-- | >>> extractMappingKeysAndValuesFromTable "<table><tr><td>Only cell</td></tr></table>"
-- | { keys: [], ... values: [] }
-- |
-- | >>> extractMappingKeysAndValuesFromTable "No table"
-- | { keys: [], ... values: [] }
-- | ```
extractMappingKeysAndValuesFromTableHtml :: String -> ExtractedData
extractMappingKeysAndValuesFromTableHtml tableHtml = 
  let nothing = { keys: [], keyIndices: empty, values: [] }
  in extractInnerCellsFromHtml tableHtml
    ?? (\cellArrays ->
      length cellArrays == 0 
        ? nothing
        ↔ let keys = cellArrays !! 1 ??⇒ []
              values = drop 3 cellArrays
          in { keys, keyIndices: arrayToIndexMap keys, values: values }
    )
    ⇔ nothing
