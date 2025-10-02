module Util.Html.Clean
  ( removeAttribute
  , removeDataAttributes
  , cleanAttributesInTag
  , cleanAttributesInTags
  , findUnescapedQuote
  , removeComments
  )
  where

import Prelude

import Data.Array (foldl, snoc)
import Data.Maybe (Maybe(..))
import Data.String (CodePoint, Pattern(..), codePointFromChar, drop, fromCodePointArray, indexOf, split, take, toCodePointArray)

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

-- | Cleans specified attributes from all HTML tags in a string.
-- | If `dataOnesToo` is true, it also removes all `data-*` attributes.
-- | Examples:
-- | ```purescript
-- | >>> cleanAttributesInTags "<div style=\"color:red;\" class=\"my-class\">Content</div><p class=\"paragraph\" id=\"para\">Text</p>" ["style", "class"] false
-- | "<div>Content</div><p id=\"para\">Text</p>"
-- | ```
cleanAttributesInTags :: String -> Array String -> Boolean -> String 
cleanAttributesInTags str attr dataOnesToo =
  let chars = toCodePointArray str
      result = foldl process { inTag: false, result: [], tagContent: [] } chars
  in fromCodePointArray result.result
  where 
  process 
    :: { inTag :: Boolean, result :: Array CodePoint, tagContent :: Array CodePoint } 
    -> CodePoint 
    -> { inTag :: Boolean, result :: Array CodePoint, tagContent :: Array CodePoint } 
  process acc codePoint
    | codePoint == codePointFromChar '<' = acc { inTag = true, tagContent = [codePoint] }
    | codePoint == codePointFromChar '>' && acc.inTag = 
        let cleanedTag = cleanAttributesInTag (fromCodePointArray acc.tagContent <> ">") attr dataOnesToo
            cleanedTagChars = toCodePointArray cleanedTag
        in acc { inTag = false, result = acc.result <> cleanedTagChars, tagContent = [] }
    | acc.inTag = acc { tagContent = snoc acc.tagContent codePoint }
    | otherwise = acc { result = snoc acc.result codePoint }

-- | Removes HTML comments from a string.
-- |
-- | Examples:
-- | ```purescript
-- | >>> removeComments "<div>Hello <strong>World</strong>!</div><!-- This is a comment -->"
-- | "<div>Hello <strong>World</strong>!</div>"
-- | >>> removeComments "<!-- comment -->Text<!-- another -->"
-- | "Text"
-- | ```
removeComments :: String -> String
removeComments str = 
  case indexOf (Pattern "<!--") str of
    Nothing -> str
    Just startIdx ->
      let beforeComment = take startIdx str
          afterStartTag = drop (startIdx + 4) str 
      in case indexOf (Pattern "-->") afterStartTag of
        Just endIdx ->
          let afterComment = drop (endIdx + 3) afterStartTag 
              result = beforeComment <> afterComment
          in removeComments result 
        Nothing -> str 