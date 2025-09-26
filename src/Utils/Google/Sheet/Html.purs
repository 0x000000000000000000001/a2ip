module Utils.Google.Sheet.Html
  ( extractCellsFromRow
  , extractTableFromHtml
  , extractTableRows
  , findColumnByKey
  , getColumnAt
  , getValueByKey
  )
  where

import Prelude

import Data.Array (drop, findIndex, index, mapMaybe) as Array
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), trim)
import Data.String as String

-- headerRowIndex :: Int
-- headerRowIndex = 2

-- dataStartRowIndex :: Int
-- dataStartRowIndex = 4

-- maxDataRows :: Int
-- maxDataRows = 6

-- maxColumns :: Int
-- maxColumns = 7

-- | Extracts the first <table>...</table> block from the given HTML string.
-- |
-- | ```purescript
-- | >>> extractTableFromHtml "<html><body><table><tr><td>1</td></tr></table></body></html>"
-- | Just "<table><tr><td>1</td></tr></table>"
-- | ```
extractTableFromHtml :: String -> Maybe String
extractTableFromHtml htmlContent =
  case String.indexOf (Pattern "<table") htmlContent of
    Nothing -> Nothing
    Just startIndex ->
      let afterTableStart = String.drop startIndex htmlContent
      in case String.indexOf (Pattern "</table>") afterTableStart of
        Nothing -> Nothing
        Just endIndexRelative ->
          let tableLength = endIndexRelative + String.length "</table>"
              extractedTable = String.take tableLength afterTableStart
          in Just extractedTable

-- | Extracts the rows from a <table>...</table> block.
-- |
-- | ```purescript
-- | >>> extractTableRows "<table><tr><td>1</td><td>2</td></tr><tr><td>3</td></tr></table>"
-- | ["<td>1</td><td>2</td>", "<td>3</td>"]
-- | ```
extractTableRows :: String -> Array String
extractTableRows tableHtml = 
  let rawRows = String.split (String.Pattern "<tr") tableHtml
      cleanedRows = Array.mapMaybe extractRowContent (Array.drop 1 rawRows)
  in cleanedRows
  where
    extractRowContent :: String -> Maybe String
    extractRowContent rowSegment =
      case String.indexOf (String.Pattern ">") rowSegment of
        Nothing -> Nothing
        Just startIdx ->
          let afterOpenTag = String.drop (startIdx + 1) rowSegment
          in case String.indexOf (String.Pattern "</tr>") afterOpenTag of
            Nothing -> Nothing
            Just endIdx ->
              let content = String.take endIdx afterOpenTag
              in Just (String.trim content)

-- | Extracts cell contents from a single row string.
-- |
-- | ```purescript
-- | >>> extractCellsFromRow "<tr><td>1</td><td>2</td></tr>"
-- | Just ["1", "2"]
-- |
-- | >>> extractCellsFromRow "<td>1</td><td><span>2</span></td>"
-- | Just ["1", "<span>2</span>"]
-- | ```
extractCellsFromRow :: String -> Maybe (Array String)
extractCellsFromRow row =
  let trimmedRow = String.trim row
  in if trimmedRow == "" then Nothing
     else
       if String.contains (Pattern "<tr") trimmedRow then
         Just $ extractAllCellsInOrder trimmedRow
       else if String.contains (Pattern "<td") trimmedRow || String.contains (Pattern "<th") trimmedRow then
         Just $ extractAllCellsInOrder trimmedRow
       else Nothing
  where 
  extractAllCellsInOrder :: String -> Array String
  extractAllCellsInOrder html = extractCellsRecursive html 0 []
  
  extractCellsRecursive :: String -> Int -> Array String -> Array String
  extractCellsRecursive html pos acc =
    let tdPos = String.indexOf (Pattern "<td") (String.drop pos html)
        thPos = String.indexOf (Pattern "<th") (String.drop pos html)
    in case { td: tdPos, th: thPos } of
         { td: Nothing, th: Nothing } -> acc
         { td: Just tdIdx, th: Nothing } -> 
           case extractNextCell "td" html (pos + tdIdx) of
             Nothing -> acc
             Just { content, nextPos } -> extractCellsRecursive html nextPos (acc <> [content])
         { td: Nothing, th: Just thIdx } ->
           case extractNextCell "th" html (pos + thIdx) of
             Nothing -> acc
             Just { content, nextPos } -> extractCellsRecursive html nextPos (acc <> [content])
         { td: Just tdIdx, th: Just thIdx } ->
           if tdIdx < thIdx then
             case extractNextCell "td" html (pos + tdIdx) of
               Nothing -> acc
               Just { content, nextPos } -> extractCellsRecursive html nextPos (acc <> [content])
           else
             case extractNextCell "th" html (pos + thIdx) of
               Nothing -> acc
               Just { content, nextPos } -> extractCellsRecursive html nextPos (acc <> [content])
  
  extractNextCell :: String -> String -> Int -> Maybe { content :: String, nextPos :: Int }
  extractNextCell tag html startPos =
    let closeTag = "</" <> tag <> ">"
        afterStart = String.drop startPos html
    in case String.indexOf (Pattern ">") afterStart of
         Nothing -> Nothing
         Just gtIdx ->
           let contentStart = startPos + gtIdx + 1
               afterContent = String.drop contentStart html
           in case String.indexOf (Pattern closeTag) afterContent of
                Nothing -> Nothing
                Just endIdx ->
                  let content = String.take endIdx afterContent
                      nextPos = contentStart + endIdx + String.length closeTag
                  in Just { content, nextPos }

-- extractRowCells :: String -> Int -> Maybe (Array String)
-- extractRowCells html rowIndex = 
--   let tableHtml = extractTableFromHtml html
--       rows = extractTableRows $ fromMaybe "" tableHtml
--       maybeRow = Array.index rows rowIndex
--   in case maybeRow of
--        Just row -> Just $ extractCellsFromRow row
--        Nothing -> Nothing

-- generateDataRowIndexes :: Int -> Int -> Array Int
-- generateDataRowIndexes startIndex maxRows = Array.range startIndex (startIndex + maxRows - 1)

-- extractRowCellsIfNotEmpty :: String -> Int -> Int -> Maybe (Array String)
-- extractRowCellsIfNotEmpty htmlContent maxCols rowIndex =
--   let allRowCells = extractRowCells htmlContent rowIndex
--       rowCells = Array.take maxCols allRowCells
--   in if Array.length rowCells > 0 then Just rowCells else Nothing

-- extractDataRows :: String -> Array (Array String)
-- extractDataRows htmlContent =
--   let rowIndexes = generateDataRowIndexes dataStartRowIndex maxDataRows
--   in Array.mapMaybe (extractRowCellsIfNotEmpty htmlContent maxColumns) rowIndexes

getColumnAt :: Int -> Array String -> String
getColumnAt pos arr = case Array.index arr pos of
  Just value -> trim value
  Nothing -> ""

findColumnByKey :: String -> Array String -> Array String -> String
findColumnByKey key mappingKeys dataColumns =
  case Array.findIndex (_ == key) mappingKeys of
    Just i -> getColumnAt i dataColumns
    Nothing -> ""

getValueByKey :: Array String -> Array String -> String -> String
getValueByKey mappingKeys rowCells key = 
  trim $ findColumnByKey key mappingKeys rowCells

-- getMeaningfulHeaders :: Int -> Array String -> Array String
-- getMeaningfulHeaders maxCols headerCells = Array.take maxCols headerCells

-- extractMappingKeysFromTable :: (String -> String) -> String -> Array String
-- extractMappingKeysFromTable headerMapper html = 
--   html
--     # flip extractRowCells headerRowIndex
--     # getMeaningfulHeaders maxColumns
--     # map headerMapper