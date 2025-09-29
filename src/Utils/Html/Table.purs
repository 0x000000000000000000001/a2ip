module Utils.Html.Table
  ( extractInnerCellsFromHtml
  , extractInnerCellsFromRow
  , extractInnerRowsFromHtml
  , extractNextInnerCell
  , extractTableFromHtml
  , getNextCellPos
  )
  where

import Prelude

import Data.Array (drop, mapMaybe) as Array
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..))
import Data.String as String

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
-- | >>> extractInnerRowsFromHtml "<table><tr><td>1</td><td>2</td></tr><tr><td>3</td></tr></table>"
-- | ["<td>1</td><td>2</td>", "<td>3</td>"]
-- | ```
extractInnerRowsFromHtml :: String -> Array String
extractInnerRowsFromHtml tableHtml = 
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
-- | >>> extractInnerCellsFromRow "<tr><td>1</td><td>2</td></tr>"
-- | Just ["1", "2"]
-- |
-- | >>> extractInnerCellsFromRow "<td>1</td><td><span>2</span></td>"
-- | Just ["1", "<span>2</span>"]
-- | ```
extractInnerCellsFromRow :: String -> Maybe (Array String)
extractInnerCellsFromRow row =
  let trimmedRow = String.trim row
  in if trimmedRow == "" then Nothing
     else
       if String.contains (Pattern "<tr") trimmedRow then
         Just $ go trimmedRow
       else if String.contains (Pattern "<td") trimmedRow || String.contains (Pattern "<th") trimmedRow then
         Just $ go trimmedRow
       else Nothing
  where 
  go :: String -> Array String
  go html = rec html 0 []
    where
    rec :: String -> Int -> Array String -> Array String
    rec h pos acc =
      case { 
        td: getNextCellPos "td" h pos false,
        th: getNextCellPos "th" h pos false
      } of
        { td: Nothing, th: Nothing } -> acc
        { td: Just _, th: Nothing } -> 
          case extractNextInnerCell "td" h pos of
            Nothing -> acc
            Just { content, nextPos } -> rec h nextPos (acc <> [content])
        { td: Nothing, th: Just _ } ->
          case extractNextInnerCell "th" h pos of
            Nothing -> acc
            Just { content, nextPos } -> rec h nextPos (acc <> [content])
        { td: Just tdIdx, th: Just thIdx } ->
          if tdIdx < thIdx then
            case extractNextInnerCell "td" h pos of
              Nothing -> acc
              Just { content, nextPos } -> rec h nextPos (acc <> [content])
          else
            case extractNextInnerCell "th" h pos of
              Nothing -> acc
              Just { content, nextPos } -> rec h nextPos (acc <> [content])

-- | Extracts all cell contents from the first <table>...</table> block in the given HTML string.
-- |
-- | ```purescript
-- | >>> extractInnerCellsFromHtml "<html><body><table><tr><td>1</td><td>2</td></tr><tr><td>3</td></tr></table></body></html>"
-- | Just [["1", "2"], ["3"]]
-- | ```
extractInnerCellsFromHtml :: String -> Maybe (Array (Array String))
extractInnerCellsFromHtml _ = Just []
  -- case extractTableFromHtml html of
  --   Nothing -> Nothing
  --   Just tableHtml ->
  --     let rows = extractInnerRowsFromHtml tableHtml
  --     in rows <#> (\r -> fromMaybe [] $ extractInnerCellsFromRow r)

-- | Finds the next occurrence of a specified HTML tag starting from a given offset.
-- | If `relative` is true, the returned index is relative to the offset position;
-- | otherwise, it's the absolute index in the original string.
-- |
-- ```purescript
-- >>> let html = "<td>First</td><td>Second</td>"
-- >>> getNextCellPos "td" html 5 true
-- Just 9
-- >>> getNextCellPos "td" html 5 false
-- Just 14
-- >>> getNextCellPos "th" html 0 false
-- Nothing
-- ```
getNextCellPos :: String -> String -> Int -> Boolean -> Maybe Int
getNextCellPos tag html offsetPos relative = 
  let searchHtml = String.drop offsetPos html
      pattern = Pattern ("<" <> tag)
  in case String.indexOf pattern searchHtml of
    Nothing -> Nothing
    Just foundPos -> 
      if relative then Just foundPos
      else Just (offsetPos + foundPos)

-- | Extracts the content of the next occurrence of a specified HTML tag starting from a given offset.
-- | Returns `Nothing` if the tag is not found or not properly closed.
-- |
-- ```purescript
-- >>> let html = "<td>First</td><td>Second</td>"
-- >>> extractNextInnerCell "td" html 0
-- Just { content: "First", nextPos: 11 }
-- >>> extractNextInnerCell "td" html 11
-- Just { content: "Second", nextPos: 22 }
-- >>> extractNextInnerCell "th" html 0
-- Nothing
-- ```
extractNextInnerCell :: String -> String -> Int -> Maybe { content :: String, nextPos :: Int }
extractNextInnerCell tag html offsetPos = 
  case getNextCellPos tag html offsetPos false of
    Nothing -> Nothing
    Just startTagPos -> 
      let closeTag = "</" <> tag <> ">"
          contentAfterStartTag = String.drop startTagPos html
      in case String.indexOf (Pattern closeTag) contentAfterStartTag of
        Nothing -> Nothing
        Just closeTagPosInContentAfterStartTag -> 
          let innerContentWithStartTag = String.take closeTagPosInContentAfterStartTag contentAfterStartTag
              innerContentWithStartTagBody = String.drop (String.length ("<" <> tag)) innerContentWithStartTag
              content = String.drop (1 + (fromMaybe 0 $ String.indexOf (Pattern ">") innerContentWithStartTagBody)) innerContentWithStartTagBody
              nextPos = startTagPos + closeTagPosInContentAfterStartTag + String.length closeTag
          in Just { content, nextPos }