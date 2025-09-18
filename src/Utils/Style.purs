module Utils.Style
  ( class_
  , classes
  , deep_
  , _with
  , _with_
  , with_
  , red
  , fontRed
  , loadingGrey
  , _select
  , padding
  , margin
  , nothing
  , raw
  , borderWidth
  , hash9
  , (<?)
  , (|*>)
  , (<&)
  , (<&>)
  , (&>)
  ) where

import Prelude

import CSS (Refinement, Selector)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Selector as CSSS
import Data.Array (foldl, (!!))
import Data.Char (toCharCode)
import Data.Int (rem)
import Data.Maybe (fromMaybe, Maybe(..))
import Data.String (Pattern(..), stripPrefix)
import Data.String.CodeUnits (toCharArray, fromCharArray)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

red :: Color
red = hsl 353.91 0.8174 0.4725

fontRed :: Color
fontRed = hsl 353.91 0.8174 0.35

loadingGrey :: Color
loadingGrey = hsl 0.0 0.0 0.9

-- | Utility function to set the class attribute on an HTML element.
-- | It automatically removes any "." prefix from the class name.
class_ :: forall r i. String -> HH.IProp (class :: String | r) i
class_ className = HP.class_ $ HH.ClassName $ stripDotPrefixFromClassName className

classes :: forall r i. Array String -> HH.IProp (class :: String | r) i
classes classNames = HP.classes $ HH.ClassName <$> (stripDotPrefixFromClassName <$> classNames)

stripDotPrefixFromClassName :: String -> String
stripDotPrefixFromClassName className = 
  fromMaybe className (stripPrefix (Pattern ".") className)

raw :: String -> String -> CSS.CSS
raw key value = CSS.key (CSS.fromString key) value

nothing :: CSS.CSS
nothing = pure unit
  
padding :: Number -> CSS.CSS
padding p = CSS.padding (CSS.rem p) (CSS.rem p) (CSS.rem p) (CSS.rem p)

margin :: Number -> CSS.CSS
margin m = CSS.margin (CSS.rem m) (CSS.rem m) (CSS.rem m) (CSS.rem m)

borderWidth :: Number -> CSS.CSS
borderWidth w = CSS.key (CSS.fromString "border-width") w

_select :: String -> CSS.CSS -> CSS.CSS
_select sel rs = CSS.select (CSS.fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 _select as <?

-- | The deep selector composer.
-- | Maps to `sel1 sel2` in CSS.
deep_ :: Selector -> String -> Selector
deep_ a b = CSSS.deep a (CSS.fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 deep_ as |*>

-- | The filter selector composer, adds a filter to a selector.
-- | Maps to something like `sel#filter`, `sel.filter` or `sel:filter` in CSS,
-- | depending on the filter.
_with :: String -> Refinement -> Selector
_with s r = CSSS.with (CSS.fromString $ "." <> stripDotPrefixFromClassName s) r

infix 6 _with as <&

-- | See `with` 
_with_ :: String -> String -> Selector
_with_ s r = _with s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 _with_ as <&>

-- | See `with` 
with_ :: Selector -> String -> Selector
with_ s r = CSSS.with s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 with_ as &>

-- | Fast polynomial hash function that generates a 9-character identifier
-- | Perfect for CSS class names with very low collision probability
hash9 :: forall a. Show a => a -> String
hash9 input = 
  let
    str = show input
    -- Multiple hash values for better distribution
    hash1 = foldl (\acc char -> ((acc * 31) + toCharCode char) `rem` 238328) 5381 (toCharArray str)  -- 62^3
    hash2 = foldl (\acc char -> ((acc * 37) + toCharCode char) `rem` 238328) 7919 (toCharArray str)  -- 62^3
    hash3 = foldl (\acc char -> ((acc * 41) + toCharCode char) `rem` 238328) 1009 (toCharArray str)  -- 62^3
    
    -- Base62 characters for CSS-safe identifiers (using 'o' instead of '0')
    chars = [ 'o','1','2','3','4','5','6','7','8','9'
      ,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
      ,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','p','q','r','s','t','u','v','w','x','y','z'
      ]
    letters = [ 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
        ,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
        ]
    
    -- Extract character from hash value
    getChar :: Int -> String
    getChar n = 
      case chars !! (n `rem` 62) of
        Just c -> fromCharArray [c]
        Nothing -> "o"
    -- Extract letter for first char
    getLetter :: Int -> String
    getLetter n = 
      case letters !! (n `rem` 52) of
        Just c -> fromCharArray [c]
        Nothing -> "A"
        
  in
  -- Use different positions from each hash for better distribution
  getLetter hash1 <>
  getChar (hash1 / 62) <> getChar (hash1 / 3844) <>
  getChar hash2 <> getChar (hash2 / 62) <> getChar (hash2 / 3844) <>
  getChar hash3 <> getChar (hash3 / 62) <> getChar (hash3 / 3844)