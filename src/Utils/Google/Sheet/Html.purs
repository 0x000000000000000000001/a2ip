module Utils.Google.Sheet.Html
  ( extractTableFromHtml
  , extractRowCells
  , extractMappingKeysFromTable
  , extractDataRows
  , getColumnAt
  , findColumnByKey
  , getValueByKey
  , headerRowIndex
  , dataStartRowIndex
  , maxDataRows
  , maxColumns
  )
  where

import Prelude

import Data.Array (drop, findIndex, index, length, mapMaybe, range, take) as Array
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), split, trim)
import Data.String as String
import Utils.Html.Clean (extractCellContent)

-- Constants for Google Sheets structure
headerRowIndex :: Int
headerRowIndex = 2

dataStartRowIndex :: Int
dataStartRowIndex = 4

maxDataRows :: Int
maxDataRows = 6

maxColumns :: Int
maxColumns = 7

extractTableFromHtml :: String -> Maybe String
extractTableFromHtml htmlContent =
  case split (Pattern "<table") htmlContent of
    [ _, rest ] -> 
      let tableStart = "<table" <> rest
      in case split (Pattern "</table>") tableStart of
           [ table, _ ] -> Just (table <> "</table>")
           _ -> Nothing
    _ -> Nothing

-- Table Row Processing
extractTableRows :: String -> Array String
extractTableRows tableHtml = String.split (String.Pattern "<tr") tableHtml

getRowAt :: Int -> Array String -> Maybe String
getRowAt rowIndex rows = Array.index rows rowIndex

extractCellsFromRow :: String -> Array String
extractCellsFromRow row =
  let cells = String.split (String.Pattern "<td") row
      cellContents = map (fromMaybe "") $ map extractCellContent (Array.drop 1 cells)
  in cellContents

-- Main function - Extract cell contents from the nth row of the table (0-indexed)
extractRowCells :: String -> Int -> Array String
extractRowCells html rowIndex = 
  let tableHtml = extractTableFromHtml html
      rows = extractTableRows $ fromMaybe "" tableHtml
      maybeRow = getRowAt rowIndex rows
  in case maybeRow of
       Just row -> extractCellsFromRow row
       Nothing -> []

-- Data Row Processing with configurable parameters
generateDataRowIndexes :: Int -> Int -> Array Int
generateDataRowIndexes startIndex maxRows = Array.range startIndex (startIndex + maxRows - 1)

extractRowCellsIfNotEmpty :: String -> Int -> Int -> Maybe (Array String)
extractRowCellsIfNotEmpty htmlContent maxCols rowIndex =
  let allRowCells = extractRowCells htmlContent rowIndex
      rowCells = Array.take maxCols allRowCells
  in if Array.length rowCells > 0 then Just rowCells else Nothing

extractDataRows :: String -> Array (Array String)
extractDataRows htmlContent =
  let rowIndexes = generateDataRowIndexes dataStartRowIndex maxDataRows
  in Array.mapMaybe (extractRowCellsIfNotEmpty htmlContent maxColumns) rowIndexes

-- Generic Data Access Functions
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

-- Generic Header Processing
getMeaningfulHeaders :: Int -> Array String -> Array String
getMeaningfulHeaders maxCols headerCells = Array.take maxCols headerCells

-- Generic mapping extraction function that accepts a header mapper function
extractMappingKeysFromTable :: (String -> String) -> String -> Array String
extractMappingKeysFromTable headerMapper html = 
  html
    # flip extractRowCells headerRowIndex
    # getMeaningfulHeaders maxColumns
    # map headerMapper