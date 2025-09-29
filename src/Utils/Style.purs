module Utils.Style
  ( (&.)
  , (.&)
  , (.&.)
  , (.?)
  , (|*.)
  , after
  , backgroundColorRed
  , backgroundColorWhite
  , backgroundWhite
  , before
  , bold
  , borderRadius1
  , borderRadius4
  , borderWidth
  , bottom0
  , classSelect
  , classWith
  , classWithClass
  , class_
  , classes
  , colorRed 
  , content
  , cursorPointer
  , deepClass
  , displayFlex
  , displayNone
  , flexGrow1
  , flexWrap
  , fontRed
  , fontSizePct
  , hash9
  , heightPct
  , heightRem
  , left0
  , loading
  , loadingGrey
  , margin1
  , margin2
  , margin4
  , marginBottom
  , marginLeft
  , marginRight
  , marginTop
  , maxHeightPct
  , maxHeightRem
  , maxWidthPct
  , maxWidthPct100
  , maxWidthRem
  , minHeightPct
  , minHeightRem
  , minWidthPct
  , minWidthPct100
  , minWidthRem
  , nothing
  , overflowHidden
  , padding1
  , padding2
  , padding4
  , paddingBottom
  , paddingLeft
  , paddingRight
  , paddingTop
  , positionAbsolute
  , positionFixed
  , positionRelative
  , raw
  , red
  , right0
  , top0
  , userSelectNone
  , widthPct
  , widthPct100
  , widthRem
  , withClass
  )
  where

import Prelude

import CSS (Refinement, Selector, StyleM, absolute, backgroundColor, borderColor, borderRadius, bottom, color, cursor, display, fixed, flex, flexGrow, fontSize, fontWeight, fromString, height, key, left, margin, maxHeight, maxWidth, minHeight, minWidth, padding, pct, position, relative, rem, right, select, top, width, wrap)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Cursor (pointer)
import CSS.Overflow (hidden, overflow)
import CSS.Selector (deep, with)
import Data.Array (foldl, (!!))
import Data.Char (toCharCode)
import Data.Int as Int 
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

backgroundWhite :: Color
backgroundWhite = hsl 196.0 1.0 0.98

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
raw k v = key (fromString k) v

nothing :: CSS.CSS
nothing = pure unit

userSelectNone :: CSS.CSS
userSelectNone = raw "user-select" "none"

displayNone :: CSS.CSS
displayNone = display CSS.displayNone

positionAbsolute :: CSS.CSS
positionAbsolute = position absolute

positionRelative :: CSS.CSS
positionRelative = position relative

positionFixed :: CSS.CSS
positionFixed = position fixed

topRem :: Number -> CSS.CSS
topRem t = top (rem t)

leftRem :: Number -> CSS.CSS
leftRem l = left (rem l)

bottomRem :: Number -> CSS.CSS
bottomRem b = bottom (rem b)

rightRem :: Number -> CSS.CSS
rightRem r = right (rem r)

top0 :: CSS.CSS
top0 = topRem 0.0

left0 :: CSS.CSS
left0 = leftRem 0.0

bottom0 :: CSS.CSS
bottom0 = bottomRem 0.0

right0 :: CSS.CSS
right0 = rightRem 0.0

overflowHidden :: CSS.CSS
overflowHidden = overflow hidden

flexWrap :: CSS.CSS
flexWrap = CSS.flexWrap wrap

flexGrow1 :: CSS.CSS
flexGrow1 = flexGrow 1.0

fontSizePct :: Number -> CSS.CSS
fontSizePct p = fontSize (pct p)

bold :: CSS.CSS
bold = fontWeight CSS.bold

loading :: StyleM Unit
loading = do 
  backgroundColor loadingGrey
  borderColor loadingGrey
  color loadingGrey

content :: String -> CSS.CSS
content s = raw "content" $ "\"" <> s <> "\""

backgroundColorRed :: CSS.CSS
backgroundColorRed = backgroundColor red

colorRed :: CSS.CSS
colorRed = color fontRed

backgroundColorWhite :: CSS.CSS
backgroundColorWhite = backgroundColor backgroundWhite

displayFlex :: CSS.CSS
displayFlex = display flex

cursorPointer :: CSS.CSS
cursorPointer = cursor pointer

widthRem :: Number -> CSS.CSS
widthRem w = width (rem w)

widthPct :: Number -> CSS.CSS
widthPct w = width (pct w)

widthPct100 :: CSS.CSS
widthPct100 = widthPct 100.0

minWidthRem :: Number -> CSS.CSS
minWidthRem w = minWidth (rem w)

minWidthPct :: Number -> CSS.CSS
minWidthPct w = minWidth (pct w)

minWidthPct100 :: CSS.CSS
minWidthPct100 = minWidthPct 100.0

maxWidthRem :: Number -> CSS.CSS
maxWidthRem w = maxWidth (rem w)

maxWidthPct :: Number -> CSS.CSS
maxWidthPct w = maxWidth (pct w)

maxWidthPct100 :: CSS.CSS
maxWidthPct100 = maxWidthPct 100.0

heightRem :: Number -> CSS.CSS
heightRem h = height (rem h)

heightPct :: Number -> CSS.CSS
heightPct h = height (pct h)

minHeightRem :: Number -> CSS.CSS
minHeightRem h = minHeight (rem h)

minHeightPct :: Number -> CSS.CSS
minHeightPct h = minHeight (pct h)

maxHeightRem :: Number -> CSS.CSS
maxHeightRem h = maxHeight (rem h)

maxHeightPct :: Number -> CSS.CSS
maxHeightPct h = maxHeight (pct h)

padding4 :: Number -> Number -> Number -> Number -> CSS.CSS
padding4 t r b l = padding (rem t) (rem r) (rem b) (rem l)
  
padding1 :: Number -> CSS.CSS
padding1 p = padding4 p p p p

padding2 :: Number -> Number -> CSS.CSS
padding2 v h = padding4 v h v h

paddingLeft :: Number -> CSS.CSS
paddingLeft p = CSS.paddingLeft (rem p)

paddingRight :: Number -> CSS.CSS
paddingRight p = CSS.paddingRight (rem p)

paddingBottom :: Number -> CSS.CSS
paddingBottom p = CSS.paddingBottom (rem p)

paddingTop :: Number -> CSS.CSS
paddingTop p = CSS.paddingTop (rem p)

margin4 :: Number -> Number -> Number -> Number -> CSS.CSS
margin4 t r b l = margin (rem t) (rem r) (rem b) (rem l)

margin1 :: Number -> CSS.CSS
margin1 m = margin4 m m m m

margin2 :: Number -> Number -> CSS.CSS
margin2 v h = margin4 v h v h

marginLeft :: Number -> CSS.CSS
marginLeft m = CSS.marginLeft (rem m)

marginRight :: Number -> CSS.CSS
marginRight m = CSS.marginRight (rem m)

marginTop :: Number -> CSS.CSS
marginTop m = CSS.marginTop (rem m)

marginBottom :: Number -> CSS.CSS
marginBottom m = CSS.marginBottom (rem m)

borderRadius4 :: Number -> Number -> Number -> Number -> CSS.CSS
borderRadius4 tl tr br bl = borderRadius (rem tl) (rem tr) (rem br) (rem bl)

borderRadius1 :: Number -> CSS.CSS
borderRadius1 r = borderRadius4 r r r r

borderWidth :: Number -> CSS.CSS
borderWidth w = raw "border-width" $ show w

classSelect :: String -> CSS.CSS -> CSS.CSS
classSelect sel rs = select (fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 classSelect as .?

-- | The deep selector composer.
-- | Maps to `sel1 sel2` in CSS.
deepClass :: Selector -> String -> Selector
deepClass a b = deep a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 deepClass as |*.

-- | The filter selector composer, adds a filter to a selector.
-- | Maps to something like `sel#filter`, `sel.filter` or `sel:filter` in CSS,
-- | depending on the filter.
classWith :: String -> Refinement -> Selector
classWith s r = with (fromString $ "." <> stripDotPrefixFromClassName s) r

infix 6 classWith as .&

-- | See `with` 
classWithClass :: String -> String -> Selector
classWithClass s r = classWith s (fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 classWithClass as .&.

-- | See `with` 
withClass :: Selector -> String -> Selector
withClass s r = with s (fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 withClass as &.

after :: Refinement
after = fromString "::after"

before :: Refinement
before = fromString "::before"

-- | Fast polynomial hash function that generates a 9-character identifier
-- | Perfect for CSS class names with very low collision probability
hash9 :: forall a. Show a => a -> String
hash9 input = 
  let
    str = show input
    -- Multiple hash values for better distribution
    hash1 = foldl (\acc char -> ((acc * 31) + toCharCode char) `Int.rem` 238328) 5381 (toCharArray str)  -- 62^3
    hash2 = foldl (\acc char -> ((acc * 37) + toCharCode char) `Int.rem` 238328) 7919 (toCharArray str)  -- 62^3
    hash3 = foldl (\acc char -> ((acc * 41) + toCharCode char) `Int.rem` 238328) 1009 (toCharArray str)  -- 62^3
    
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
      case chars !! (n `Int.rem` 62) of
        Just c -> fromCharArray [c]
        Nothing -> "o"
    -- Extract letter for first char
    getLetter :: Int -> String
    getLetter n = 
      case letters !! (n `Int.rem` 52) of
        Just c -> fromCharArray [c]
        Nothing -> "A"
        
  in
  -- Use different positions from each hash for better distribution
  getLetter hash1 <>
  getChar (hash1 / 62) <> getChar (hash1 / 3844) <>
  getChar hash2 <> getChar (hash2 / 62) <> getChar (hash2 / 3844) <>
  getChar hash3 <> getChar (hash3 / 62) <> getChar (hash3 / 3844)