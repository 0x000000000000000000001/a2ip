module Component.Page.About.HandleAction
  ( handleAction
  )
  where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat (arrayBuffer)
import Affjax.Web (get)
import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), Member, State)
import Data.Array (index, drop, findIndex, mapMaybe, length, range, take, foldl, snoc) as Array
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), split, trim)
import Data.String as String
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



googleSheetHtmlZipDownloadUrl :: String
googleSheetHtmlZipDownloadUrl = googleSheetUrl <> "/export?format=zip"



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

extractTableFromHtml :: String -> String
extractTableFromHtml htmlContent =
  let
    tableStart = case split (Pattern "<table") htmlContent of
      [ _, rest ] -> "<table" <> rest
      _ -> htmlContent
    
    ans = case split (Pattern "</table>") tableStart of
      [ table, _ ] -> table <> "</table>"
      _ -> tableStart
  in
    ans

-- Extract cell contents from the nth row of the table (0-indexed)
extractRowCells :: String -> Int -> Array String
extractRowCells html rowIndex = 
  let tableHtml = extractTableFromHtml html
      rows = String.split (String.Pattern "<tr") tableHtml
      targetRow = Array.index rows rowIndex
  in case targetRow of
       Just row -> 
         let cells = String.split (String.Pattern "<td") row
             -- Use map instead of mapMaybe to preserve empty cells and column alignment
             cellContents = map (fromMaybe "") $ map extractCellContent (Array.drop 1 cells)
         in cellContents
       Nothing -> []
  where
    extractCellContent :: String -> Maybe String
    extractCellContent cell = 
      case String.indexOf (String.Pattern "</td>") cell of
        Just endIdx -> 
          let cellContent = String.take endIdx cell
              -- First extract content after the closing > of the opening tag
              afterOpenTag = case String.indexOf (String.Pattern ">") cellContent of
                Just gtIdx -> String.drop (gtIdx + 1) cellContent
                Nothing -> cellContent
              -- Then extract text content, handling links and other HTML
              textContent = extractTextFromHtml afterOpenTag
              -- Decode HTML entities
              decodedContent = decodeHtmlEntities textContent
              trimmedContent = String.trim decodedContent
          -- Return empty string for empty cells instead of Nothing to preserve column alignment
          in Just trimmedContent
        Nothing -> Nothing
    
    extractTextFromHtml :: String -> String
    extractTextFromHtml str = 
      -- Simple and robust approach: extract text and preserve simple links
      let textWithLinks = extractTextAndLinks str
      in String.trim textWithLinks
    
    extractTextAndLinks :: String -> String
    extractTextAndLinks str = 
      case String.indexOf (String.Pattern "<a ") str of
        Just linkStart ->
          let beforeLink = String.take linkStart str
              afterLinkStart = String.drop linkStart str
          in case String.indexOf (String.Pattern "href=\"") afterLinkStart of
            Just hrefStart ->
              case String.indexOf (String.Pattern "\"") (String.drop (hrefStart + 6) afterLinkStart) of
                Just hrefEnd ->
                  let hrefValue = String.take hrefEnd (String.drop (hrefStart + 6) afterLinkStart)
                      afterHref = String.drop (hrefStart + 6 + hrefEnd) afterLinkStart
                  in case String.indexOf (String.Pattern ">") afterHref of
                    Just tagEnd ->
                      let afterTagEnd = String.drop (tagEnd + 1) afterHref
                      in case String.indexOf (String.Pattern "</a>") afterTagEnd of
                        Just linkTextEnd ->
                          let linkText = String.take linkTextEnd afterTagEnd
                              afterLink = String.drop (linkTextEnd + 4) afterTagEnd
                              cleanBefore = removeAllTags beforeLink
                              cleanAfter = extractTextAndLinks afterLink
                              linkHtml = "<a href=\"" <> hrefValue <> "\">" <> linkText <> "</a>"
                          in cleanBefore <> linkHtml <> cleanAfter
                        Nothing -> removeAllTags str
                    Nothing -> removeAllTags str
                Nothing -> removeAllTags str
            Nothing -> removeAllTags str
        Nothing -> removeAllTags str
    
    removeAllTags :: String -> String
    removeAllTags str =
      let chars = String.toCodePointArray str
          result = Array.foldl processChar { inTag: false, result: [] } chars
      in String.fromCodePointArray result.result
      where
        processChar acc codePoint
          | codePoint == String.codePointFromChar '<' = acc { inTag = true }
          | codePoint == String.codePointFromChar '>' = acc { inTag = false }
          | acc.inTag = acc
          | otherwise = acc { result = Array.snoc acc.result codePoint }
    
    decodeHtmlEntities :: String -> String
    decodeHtmlEntities str = 
      str
        # String.replace (String.Pattern "&#39;") (String.Replacement "'")
        # String.replace (String.Pattern "&quot;") (String.Replacement "\"")
        # String.replace (String.Pattern "&amp;") (String.Replacement "&")
        # String.replace (String.Pattern "&lt;") (String.Replacement "<")
        # String.replace (String.Pattern "&gt;") (String.Replacement ">")
        # String.replace (String.Pattern "&nbsp;") (String.Replacement " ")

-- Extract mapping keys from the headers row (row 2 contains "Prénom", "Nom", etc.)
extractMappingKeysFromTable :: String -> Array String
extractMappingKeysFromTable html = 
  let headerCells = extractRowCells html 2  -- Row 2 contains the actual headers
      -- Only take the first 7 columns that have meaningful headers
      meaningfulHeaders = Array.take 7 headerCells
      mappingKeys = map headerToMappingKey meaningfulHeaders
  in mappingKeys

-- Convert header text to mapping key format
headerToMappingKey :: String -> String
headerToMappingKey header = case header of
  "Prénom" -> "firstname"
  "Nom" -> "lastname" 
  "Fonction A2IP" -> "role"
  "Profession" -> "job"
  "Email" -> "email"
  "Numéro de tél" -> "phone"
  "Lien ou ID du portrait" -> "portraitId"
  _ -> header -- Keep original if no mapping found

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadCsvData -> do
    result <- H.liftAff $ fetchHtmlData membersTabId

    case result of
      Left err -> log Error $ "Failed to load sheet data: " <> show err
      Right members_ -> H.modify_ _ { members = members_ }
  
  LoadHtmlData -> do
    result <- H.liftAff $ get arrayBuffer googleSheetHtmlZipDownloadUrl
    case result of
      Left err -> log Error $ "Failed to fetch ZIP: " <> AX.printError err
      Right response -> do
        let tabName = fromMaybe "" $ tabIdToName membersTabId
        htmlContent <- H.liftAff $ unzipGoogleSheetAndExtractHtml tabName response.body
        let mappingKeys = extractMappingKeysFromTable htmlContent
        log Info $ "Mapping keys: " <> show mappingKeys
        -- Debug first few data rows
        let row4 = extractRowCells htmlContent 4
            row5 = extractRowCells htmlContent 5
        log Info $ "Row 4 (Sophie) data: " <> show row4
        log Info $ "Row 5 (Christelle) data: " <> show row5
        
        -- Debug: Let's look at the raw HTML for Sophie's row to see the job cell
        let tableHtml = extractTableFromHtml htmlContent
            rows = String.split (String.Pattern "<tr") tableHtml
        case Array.index rows 4 of
          Just sophieRow -> do
            let cells = String.split (String.Pattern "<td") sophieRow
            case Array.index cells 4 of  -- Job cell should be index 4 (0-based, skip first empty)
              Just jobCell -> log Info $ "Sophie's job cell HTML: " <> String.take 300 jobCell
              Nothing -> log Info $ "Sophie's job cell not found"
          Nothing -> log Info $ "Sophie's row not found"
        
        -- Process the data
        let members_ = parseHtml htmlContent
        log Info $ "HTML data loaded successfully with " <> show (Array.length members_) <> " members"
        H.modify_ _ { members = members_ }

fetchHtmlData :: forall m. MonadAff m => String -> m (Either Error (Array (Maybe Member)))
fetchHtmlData tabId = H.liftAff do
  result <- get arrayBuffer googleSheetHtmlZipDownloadUrl

  case result of
    Left err -> pure $ Left $ error $ "HTTP error: " <> AX.printError err
    Right response -> do
      let tabName = fromMaybe "" $ tabIdToName tabId
      htmlContent <- unzipGoogleSheetAndExtractHtml tabName response.body
      pure $ Right $ parseHtml htmlContent



parseHtml :: String -> Array (Maybe Member)
parseHtml htmlContent =
  let
    mappingKeys = extractMappingKeysFromTable htmlContent
    -- Skip rows 0,1,2,3 (header stuff) and start from row 4 for actual data
    dataRowIndexes = Array.range 4 9  -- Assuming max 6 data rows, adjust as needed
    dataRows = Array.mapMaybe (\i -> 
      let allRowCells = extractRowCells htmlContent i
          -- Only take the first 7 columns to match the mapping keys
          rowCells = Array.take 7 allRowCells
      in if Array.length rowCells > 0 then Just { index: i, cells: rowCells } else Nothing
    ) dataRowIndexes
  in
    map (\rowData -> parseHtmlRowWithMappingDebug mappingKeys rowData.cells rowData.index) dataRows

parseHtmlRowWithMappingDebug :: Array String -> Array String -> Int -> Maybe Member
parseHtmlRowWithMappingDebug mappingKeys rowCells _ =
  parseHtmlRowWithMapping mappingKeys rowCells

parseHtmlRowWithMapping :: Array String -> Array String -> Maybe Member
parseHtmlRowWithMapping mappingKeys rowCells =
  let
    val key = trim $ colByKey key rowCells

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
      { lastname: val "lastname"
      , firstname: val "firstname"
      , role: val "role"
      , job: val "job"
      , email: val "email"
      , phone: val "phone"
      , portraitId: extractPortraitIdFromViewUrl $ val "portraitId"
      }


