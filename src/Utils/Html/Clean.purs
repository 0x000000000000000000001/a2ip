module Utils.Html.Clean
  ( removeAttribute
  , removeDataAttributes
  , cleanAttributesInTag
  , extractTextFromHtml
  , cleanAttributesInTags
  , findUnescapedQuote
  )
  where

import Prelude

import Data.Array (foldl, snoc)
import Data.Maybe (Maybe(..))
import Data.String (CodePoint, Pattern(..), codePointFromChar, drop, fromCodePointArray, indexOf, split, take, toCodePointArray, trim)

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
          let afterAttr = drop (endQuote + 1) after
              cleanAfter = case take 1 afterAttr of
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
      case indexOf (Pattern " data-") str of
        Just dataStart ->
          let beforeData = take dataStart str
              afterDataStart = drop dataStart str
          in case indexOf (Pattern "=\"") afterDataStart of
            Just eqStart ->
              let valueStart = drop (eqStart + 2) afterDataStart
              in case findUnescapedQuote valueStart 0 of
                Just endQuote ->
                  let afterDataAttr = drop (endQuote + 1) valueStart
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
  case indexOf (Pattern "\"") (drop pos str) of
    Nothing -> Nothing
    Just quotePos ->
      let absolutePos = pos + quotePos
      in if absolutePos > 0 && take 1 (drop (absolutePos - 1) str) == "\\"
          then findUnescapedQuote str (absolutePos + 1)
          else Just absolutePos

-- | Cleans specified attributes from a single HTML tag string.
-- | If `dataOnesToo` is true, it also removes all `data-*` attributes.
-- |
-- | Examples:
-- | ```purescript
-- | >>> cleanAttributesInTag "<div style=\"color:red;\" class=\"my-class\" id=\"test\" data-test=\"yes\">" ["style", "class"] true
-- | "<div id=\"test\">"
-- | ```
cleanAttributesInTag :: String -> Array String -> Boolean -> String
cleanAttributesInTag tag attr dataOnesToo =
  foldl (\t a -> removeAttribute a t) tag attr
    # if dataOnesToo then removeDataAttributes else identity

type CleanAttrState = { inTag :: Boolean, result :: Array CodePoint, tagContent :: Array CodePoint } 

cleanAttributesInTags :: String -> Array String -> Boolean -> String 
cleanAttributesInTags str attr dataOnesToo =
  let chars = toCodePointArray str
      result = foldl process { inTag: false, result: [], tagContent: [] } chars
  in fromCodePointArray result.result
  where 
  process 
    :: CleanAttrState
    -> CodePoint 
    -> CleanAttrState
  process acc codePoint
    | codePoint == codePointFromChar '<' = acc { inTag = true, tagContent = [codePoint] }
    | codePoint == codePointFromChar '>' && acc.inTag = 
        let cleanedTag = cleanAttributesInTag (fromCodePointArray acc.tagContent <> ">") attr dataOnesToo
            cleanedTagChars = toCodePointArray cleanedTag
        in acc { inTag = false, result = acc.result <> cleanedTagChars, tagContent = [] }
    | acc.inTag = acc { tagContent = snoc acc.tagContent codePoint }
    | otherwise = acc { result = snoc acc.result codePoint }

extractTextFromHtml :: String -> String
extractTextFromHtml str = cleanAttributesInTags (trim str) [] false