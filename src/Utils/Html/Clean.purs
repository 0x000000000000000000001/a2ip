module Utils.Html.Clean
  ( removeAttribute
  , removeDataAttributes
  , cleanTag
  , cleanHtmlAttributes
  , extractTextFromHtml
  , TagProcessState
  , processCharInHtml
  , cleanAttributesInTags
  )
  where

import Prelude

import Data.Array (foldl, snoc) as Array
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split)
import Data.String as String

-- | Remove a specific attribute from an HTML tag string.
-- |
-- | Examples:
-- | ```purescript
-- | >>> removeAttribute "style" "<div style=\"color:red;\" class=\"my-class\">"
-- | "<div class=\"my-class\">"
-- | ```
removeAttribute :: String -> String -> String
removeAttribute attrName tag =
  let pattern = Pattern (" " <> attrName <> "=\"")
      parts = split pattern tag
  in case parts of
    [before, after] ->
      case findUnescapedQuote after 0 of
        Just endQuote ->
          let afterAttr = String.drop (endQuote + 1) after
              cleanAfter = case String.take 1 afterAttr of
                " " -> afterAttr
                _ -> afterAttr
          in before <> cleanAfter
        Nothing -> tag
    _ -> tag

-- | Remove all attributes starting with "data-" from an HTML tag string.
-- |
-- | Examples:
-- | ```purescript
-- | >>> removeDataAttributes "<div data-id=\"123\" data-value=\"test\" class=\"my-class\">"
-- | "<div class=\"my-class\">"
-- | ```
removeDataAttributes :: String -> String
removeDataAttributes tag = removeDataAttr tag
  where
    removeDataAttr str =
      case String.indexOf (Pattern " data-") str of
        Just dataStart ->
          let beforeData = String.take dataStart str
              afterDataStart = String.drop dataStart str
          in case String.indexOf (Pattern "=\"") afterDataStart of
            Just eqStart ->
              let valueStart = String.drop (eqStart + 2) afterDataStart
              in case findUnescapedQuote valueStart 0 of
                Just endQuote ->
                  let afterDataAttr = String.drop (endQuote + 1) valueStart
                  in removeDataAttr (beforeData <> afterDataAttr)
                Nothing -> str 
            Nothing -> str 
        Nothing -> str

-- | Helper function to find the position of the next unescaped quote in a string.
-- | Returns `Nothing` if no unescaped quote is found.
-- | 
-- | Examples:
-- | ```purescript
-- | >>> findUnescapedQuote "value with \\\"escaped quote\\\" and \" end" 0
-- | Just 36
-- | >>> findUnescapedQuote "no quotes here" 0
-- | Nothing  
-- | ```
findUnescapedQuote :: String -> Int -> Maybe Int
findUnescapedQuote str pos =
  case String.indexOf (Pattern "\"") (String.drop pos str) of
    Nothing -> Nothing
    Just quotePos ->
      let absolutePos = pos + quotePos
      in if absolutePos > 0 && String.take 1 (String.drop (absolutePos - 1) str) == "\\"
          then findUnescapedQuote str (absolutePos + 1)
          else Just absolutePos

cleanTag :: String -> String
cleanTag tag =
  tag
    # removeAttribute "style"
    # removeAttribute "class" 
    # removeAttribute "id"
    # removeDataAttributes

-- HTML Processing
type TagProcessState = { inTag :: Boolean, result :: Array String.CodePoint, tagContent :: Array String.CodePoint }

processCharInHtml :: TagProcessState -> String.CodePoint -> TagProcessState
processCharInHtml acc codePoint
  | codePoint == String.codePointFromChar '<' = acc { inTag = true, tagContent = [codePoint] }
  | codePoint == String.codePointFromChar '>' && acc.inTag = 
      let cleanedTag = cleanTag (String.fromCodePointArray acc.tagContent <> ">")
          cleanedTagChars = String.toCodePointArray cleanedTag
      in acc { inTag = false, result = acc.result <> cleanedTagChars, tagContent = [] }
  | acc.inTag = acc { tagContent = Array.snoc acc.tagContent codePoint }
  | otherwise = acc { result = Array.snoc acc.result codePoint }

cleanAttributesInTags :: String -> String
cleanAttributesInTags str =
  let chars = String.toCodePointArray str
      result = Array.foldl processCharInHtml { inTag: false, result: [], tagContent: [] } chars
  in String.fromCodePointArray result.result

cleanHtmlAttributes :: String -> String
cleanHtmlAttributes = cleanAttributesInTags

extractTextFromHtml :: String -> String
extractTextFromHtml str = 
  let cleanedHtml = cleanHtmlAttributes str
  in String.trim cleanedHtml