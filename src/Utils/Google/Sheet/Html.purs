module Utils.Google.Sheet.Html
  ( extractTableFromHtml
  , extractTableRows
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
import Data.String (Pattern(..), trim)
import Data.String as String
import Utils.Html.Clean (extractCellContent)

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

extractTableRows :: String -> Array String
extractTableRows tableHtml = String.split (String.Pattern "<tr") tableHtml

getRowAt :: Int -> Array String -> Maybe String
getRowAt rowIndex rows = Array.index rows rowIndex

extractCellsFromRow :: String -> Array String
extractCellsFromRow row =
  let cells = String.split (String.Pattern "<td") row
      cellContents = map (fromMaybe "") $ map extractCellContent (Array.drop 1 cells)
  in cellContents

extractRowCells :: String -> Int -> Array String
extractRowCells html rowIndex = 
  let tableHtml = extractTableFromHtml html
      rows = extractTableRows $ fromMaybe "" tableHtml
      maybeRow = getRowAt rowIndex rows
  in case maybeRow of
       Just row -> extractCellsFromRow row
       Nothing -> []

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

getMeaningfulHeaders :: Int -> Array String -> Array String
getMeaningfulHeaders maxCols headerCells = Array.take maxCols headerCells

extractMappingKeysFromTable :: (String -> String) -> String -> Array String
extractMappingKeysFromTable headerMapper html = 
  html
    # flip extractRowCells headerRowIndex
    # getMeaningfulHeaders maxColumns
    # map headerMapper