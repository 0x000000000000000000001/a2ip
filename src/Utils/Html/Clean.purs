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

-- HTML Attribute Cleaning
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
removeDataAttributes tag = removeDataAttr tag
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