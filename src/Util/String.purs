module Util.String
  ( padLeft
  , padRight
  , removeAccents
  , slugify
  ) where

import Proem

import Data.Array (replicate)
import Data.String (Pattern(..), Replacement(..), replaceAll, toLower, trim)
import Data.String.CodeUnits (fromCharArray, length)
import Data.String.Regex (regex)
import Data.String.Regex (replace) as Regex
import Data.String.Regex.Flags (global)

-- | Pad a string on the left with a character to reach a minimum width
-- |
-- | Examples:
-- | ```purescript
-- | >>> padLeft 2 "0" "5"
-- | "05"
-- |
-- | >>> padLeft 4 " " "hi"
-- | "  hi"
-- |
-- | >>> padLeft 2 "0" "123"
-- | "123"
-- | ```
padLeft :: Int -> Char -> String -> String
padLeft width padChar str =
  let
    padding = width - length str
  in
    ( padding <= 0
        ? str
        ↔ (fromCharArray (replicate padding padChar) <> str)
    )

-- | Pad a string on the right with a character to reach a minimum width
-- |
-- | Examples:
-- | ```purescript
-- | >>> padRight 4 " " "hi"
-- | "hi  "
-- |
-- | >>> padRight 5 "0" "123"
-- | "12300"
-- | ```
padRight :: Int -> Char -> String -> String
padRight width padChar str =
  let
    padding = width - length str
  in
    ( padding <= 0
        ? str
        ↔ (str <> fromCharArray (replicate padding padChar))
    )

-- | Converts a string to a URL-friendly slug
-- |
-- | Examples:
-- | ```purescript
-- | >>> slugify "Christelle Evita"
-- | "christelle-evita"
-- |
-- | >>> slugify "Jean-Paul Dupont"
-- | "jean-paul-dupont"
-- |
-- | >>> slugify "  Marie  Louise  "
-- | "marie-louise"
-- | ```
slugify :: String -> String
slugify str =
  str
    # trim
    # toLower
    # removeAccents
    # replaceSpacesWithDashes
    # removeInvalidChars
    # removeConsecutiveDashes
    # trimDashes
  where
  replaceSpacesWithDashes :: String -> String
  replaceSpacesWithDashes = replaceAll (Pattern " ") (Replacement "-")

  removeInvalidChars :: String -> String
  removeInvalidChars s =
    regex "[^a-z0-9-]" global
      ?! (\re -> Regex.replace re "" s)
      ⇿ (κ s)

  removeConsecutiveDashes :: String -> String
  removeConsecutiveDashes s =
    regex "-+" global
      ?! (\re -> Regex.replace re "-" s)
      ⇿ (κ s)

  trimDashes :: String -> String
  trimDashes s =
    regex "^-+|-+$" global
      ?! (\re -> Regex.replace re "" s)
      ⇿ (κ s)

-- | Remove accents from characters
-- | Simple version - only handles common French accents
removeAccents :: String -> String
removeAccents str =
  str
    # replaceAll (Pattern "é") (Replacement "e")
    # replaceAll (Pattern "è") (Replacement "e")
    # replaceAll (Pattern "ê") (Replacement "e")
    # replaceAll (Pattern "ë") (Replacement "e")
    # replaceAll (Pattern "à") (Replacement "a")
    # replaceAll (Pattern "â") (Replacement "a")
    # replaceAll (Pattern "ä") (Replacement "a")
    # replaceAll (Pattern "ô") (Replacement "o")
    # replaceAll (Pattern "ö") (Replacement "o")
    # replaceAll (Pattern "ù") (Replacement "u")
    # replaceAll (Pattern "û") (Replacement "u")
    # replaceAll (Pattern "ü") (Replacement "u")
    # replaceAll (Pattern "ï") (Replacement "i")
    # replaceAll (Pattern "î") (Replacement "i")
    # replaceAll (Pattern "ç") (Replacement "c")
    # replaceAll (Pattern "É") (Replacement "E")
    # replaceAll (Pattern "È") (Replacement "E")
    # replaceAll (Pattern "Ê") (Replacement "E")
    # replaceAll (Pattern "Ë") (Replacement "E")
    # replaceAll (Pattern "À") (Replacement "A")
    # replaceAll (Pattern "Â") (Replacement "A")
    # replaceAll (Pattern "Ä") (Replacement "A")
    # replaceAll (Pattern "Ô") (Replacement "O")
    # replaceAll (Pattern "Ö") (Replacement "O")
    # replaceAll (Pattern "Ù") (Replacement "U")
    # replaceAll (Pattern "Û") (Replacement "U")
    # replaceAll (Pattern "Ü") (Replacement "U")
    # replaceAll (Pattern "Ï") (Replacement "I")
    # replaceAll (Pattern "Î") (Replacement "I")
    # replaceAll (Pattern "Ç") (Replacement "C")
