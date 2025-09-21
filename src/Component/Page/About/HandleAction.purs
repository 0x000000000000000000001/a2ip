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
import Data.Array (drop, findIndex, foldl, index, length, mapMaybe, range, snoc, take) as Array
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
      -- Preserve all HTML but clean unwanted attributes
      let cleanedHtml = cleanHtmlAttributes str
      in String.trim cleanedHtml
    
    cleanHtmlAttributes :: String -> String
    cleanHtmlAttributes str = 
      cleanAttributesInTags str
    
    cleanAttributesInTags :: String -> String
    cleanAttributesInTags str =
      let chars = String.toCodePointArray str
          result = Array.foldl processChar { inTag: false, result: [], tagContent: [] } chars
      in String.fromCodePointArray result.result
      where
        processChar acc codePoint
          | codePoint == String.codePointFromChar '<' = acc { inTag = true, tagContent = [codePoint] }
          | codePoint == String.codePointFromChar '>' && acc.inTag = 
              let cleanedTag = cleanTag (String.fromCodePointArray acc.tagContent <> ">")
                  cleanedTagChars = String.toCodePointArray cleanedTag
              in acc { inTag = false, result = acc.result <> cleanedTagChars, tagContent = [] }
          | acc.inTag = acc { tagContent = Array.snoc acc.tagContent codePoint }
          | otherwise = acc { result = Array.snoc acc.result codePoint }
    
    cleanTag :: String -> String
    cleanTag tag =
      -- Remove style, class, id, and data-* attributes from HTML tags
      tag
        # removeAttribute "style"
        # removeAttribute "class" 
        # removeAttribute "id"
        # removeDataAttributes
    
    removeAttribute :: String -> String -> String
    removeAttribute attrName tag =
      let pattern = Pattern (" " <> attrName <> "=\"")
          parts = split pattern tag
      in case parts of
        [before, after] ->
          case String.indexOf (Pattern "\"") after of
            Just endQuote ->
              let afterAttr = String.drop (endQuote + 1) after
                  -- Remove any trailing space if it was between attributes
                  cleanAfter = case String.take 1 afterAttr of
                    " " -> afterAttr
                    _ -> afterAttr
              in before <> cleanAfter
            Nothing -> tag -- Malformed attribute, keep original
        _ -> tag -- Attribute not found, keep original
    
    removeDataAttributes :: String -> String
    removeDataAttributes tag =
      -- Remove all data-* attributes using regex-like approach
      removeDataAttr tag
      where
        removeDataAttr str =
          case String.indexOf (Pattern " data-") str of
            Just dataStart ->
              let beforeData = String.take dataStart str
                  afterDataStart = String.drop dataStart str
              in case String.indexOf (Pattern "=\"") afterDataStart of
                Just eqStart ->
                  case String.indexOf (Pattern "\"") (String.drop (eqStart + 2) afterDataStart) of
                    Just endQuote ->
                      let afterDataAttr = String.drop (eqStart + 2 + endQuote + 1) afterDataStart
                      in removeDataAttr (beforeData <> afterDataAttr)
                    Nothing -> str -- Malformed, keep original
                Nothing -> str -- Malformed, keep original
            Nothing -> str -- No more data attributes

    
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
        let members_ = parseHtml htmlContent
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
      in if Array.length rowCells > 0 then Just rowCells else Nothing
    ) dataRowIndexes
  in
    map (parseHtmlRowWithMapping mappingKeys) dataRows

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


