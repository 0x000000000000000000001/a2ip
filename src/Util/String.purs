module Util.String
  ( removeAccents
  , slugify
  )
  where

import Prelude

import Data.Either (Either(..))
import Data.String (Pattern(..), Replacement(..), replace, toLower, trim)
import Data.String.Regex (regex, replace) as Regex
import Data.String.Regex.Flags (global) as RegexFlags

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
  -- | Replace spaces with dashes
  replaceSpacesWithDashes :: String -> String
  replaceSpacesWithDashes = replace (Pattern " ") (Replacement "-")

  -- | Remove invalid characters (keep only alphanumeric and dashes)
  removeInvalidChars :: String -> String
  removeInvalidChars s =
    case Regex.regex "[^a-z0-9-]" RegexFlags.global of
      Right re -> Regex.replace re "" s
      Left _ -> s

  -- | Remove consecutive dashes
  removeConsecutiveDashes :: String -> String
  removeConsecutiveDashes s =
    case Regex.regex "-+" RegexFlags.global of
      Right re -> Regex.replace re "-" s
      Left _ -> s

  -- | Trim dashes from start and end
  trimDashes :: String -> String
  trimDashes s =
    case Regex.regex "^-+|-+$" RegexFlags.global of
      Right re -> Regex.replace re "" s
      Left _ -> s

-- | Remove accents from characters
-- | Simple version - only handles common French accents
removeAccents :: String -> String
removeAccents str =
  str
    # replace (Pattern "é") (Replacement "e")
    # replace (Pattern "è") (Replacement "e")
    # replace (Pattern "ê") (Replacement "e")
    # replace (Pattern "ë") (Replacement "e")
    # replace (Pattern "à") (Replacement "a")
    # replace (Pattern "â") (Replacement "a")
    # replace (Pattern "ä") (Replacement "a")
    # replace (Pattern "ô") (Replacement "o")
    # replace (Pattern "ö") (Replacement "o")
    # replace (Pattern "ù") (Replacement "u")
    # replace (Pattern "û") (Replacement "u")
    # replace (Pattern "ü") (Replacement "u")
    # replace (Pattern "ï") (Replacement "i")
    # replace (Pattern "î") (Replacement "i")
    # replace (Pattern "ç") (Replacement "c")
    # replace (Pattern "É") (Replacement "E")
    # replace (Pattern "È") (Replacement "E")
    # replace (Pattern "Ê") (Replacement "E")
    # replace (Pattern "Ë") (Replacement "E")
    # replace (Pattern "À") (Replacement "A")
    # replace (Pattern "Â") (Replacement "A")
    # replace (Pattern "Ä") (Replacement "A")
    # replace (Pattern "Ô") (Replacement "O")
    # replace (Pattern "Ö") (Replacement "O")
    # replace (Pattern "Ù") (Replacement "U")
    # replace (Pattern "Û") (Replacement "U")
    # replace (Pattern "Ü") (Replacement "U")
    # replace (Pattern "Ï") (Replacement "I")
    # replace (Pattern "Î") (Replacement "I")
    # replace (Pattern "Ç") (Replacement "C")
