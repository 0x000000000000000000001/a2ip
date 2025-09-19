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
  , widthPct
  , widthPct100
  , widthRem
  , withClass
  )
  where

import Prelude

import CSS (Refinement, Selector, StyleM, backgroundColor, borderColor, color, cursor, flexGrow)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Cursor (pointer)
import CSS.Overflow (hidden, overflow)
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
raw key value = CSS.key (CSS.fromString key) value

nothing :: CSS.CSS
nothing = pure unit

displayNone :: CSS.CSS
displayNone = CSS.display CSS.displayNone

positionAbsolute :: CSS.CSS
positionAbsolute = CSS.position CSS.absolute

positionRelative :: CSS.CSS
positionRelative = CSS.position CSS.relative

positionFixed :: CSS.CSS
positionFixed = CSS.position CSS.fixed

topRem :: Number -> CSS.CSS
topRem t = CSS.top (CSS.rem t)

leftRem :: Number -> CSS.CSS
leftRem l = CSS.left (CSS.rem l)

bottomRem :: Number -> CSS.CSS
bottomRem b = CSS.bottom (CSS.rem b)

rightRem :: Number -> CSS.CSS
rightRem r = CSS.right (CSS.rem r)

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
flexWrap = CSS.flexWrap CSS.wrap

flexGrow1 :: CSS.CSS
flexGrow1 = flexGrow 1.0

fontSizePct :: Number -> CSS.CSS
fontSizePct p = CSS.fontSize (CSS.pct p)

bold :: CSS.CSS
bold = CSS.fontWeight CSS.bold

loading :: StyleM Unit
loading = do 
  backgroundColor loadingGrey
  borderColor loadingGrey
  color loadingGrey

content :: String -> CSS.CSS
content s = raw "content" $ "\"" <> s <> "\""

backgroundColorRed :: CSS.CSS
backgroundColorRed = CSS.backgroundColor red

colorRed :: CSS.CSS
colorRed = CSS.color fontRed

backgroundColorWhite :: CSS.CSS
backgroundColorWhite = CSS.backgroundColor backgroundWhite

displayFlex :: CSS.CSS
displayFlex = CSS.display CSS.flex

cursorPointer :: CSS.CSS
cursorPointer = cursor pointer

widthRem :: Number -> CSS.CSS
widthRem w = CSS.width (CSS.rem w)

widthPct :: Number -> CSS.CSS
widthPct w = CSS.width (CSS.pct w)

widthPct100 :: CSS.CSS
widthPct100 = widthPct 100.0

minWidthRem :: Number -> CSS.CSS
minWidthRem w = CSS.minWidth (CSS.rem w)

minWidthPct :: Number -> CSS.CSS
minWidthPct w = CSS.minWidth (CSS.pct w)

minWidthPct100 :: CSS.CSS
minWidthPct100 = minWidthPct 100.0

maxWidthRem :: Number -> CSS.CSS
maxWidthRem w = CSS.maxWidth (CSS.rem w)

maxWidthPct :: Number -> CSS.CSS
maxWidthPct w = CSS.maxWidth (CSS.pct w)

maxWidthPct100 :: CSS.CSS
maxWidthPct100 = maxWidthPct 100.0

heightRem :: Number -> CSS.CSS
heightRem h = CSS.height (CSS.rem h)

heightPct :: Number -> CSS.CSS
heightPct h = CSS.height (CSS.pct h)

minHeightRem :: Number -> CSS.CSS
minHeightRem h = CSS.minHeight (CSS.rem h)

minHeightPct :: Number -> CSS.CSS
minHeightPct h = CSS.minHeight (CSS.pct h)

maxHeightRem :: Number -> CSS.CSS
maxHeightRem h = CSS.maxHeight (CSS.rem h)

maxHeightPct :: Number -> CSS.CSS
maxHeightPct h = CSS.maxHeight (CSS.pct h)

padding4 :: Number -> Number -> Number -> Number -> CSS.CSS
padding4 t r b l = CSS.padding (CSS.rem t) (CSS.rem r) (CSS.rem b) (CSS.rem l)
  
padding1 :: Number -> CSS.CSS
padding1 p = padding4 p p p p

padding2 :: Number -> Number -> CSS.CSS
padding2 v h = padding4 v h v h

paddingLeft :: Number -> CSS.CSS
paddingLeft p = CSS.paddingLeft (CSS.rem p)

paddingRight :: Number -> CSS.CSS
paddingRight p = CSS.paddingRight (CSS.rem p)

paddingBottom :: Number -> CSS.CSS
paddingBottom p = CSS.paddingBottom (CSS.rem p)

paddingTop :: Number -> CSS.CSS
paddingTop p = CSS.paddingTop (CSS.rem p)

margin4 :: Number -> Number -> Number -> Number -> CSS.CSS
margin4 t r b l = CSS.margin (CSS.rem t) (CSS.rem r) (CSS.rem b) (CSS.rem l)

margin1 :: Number -> CSS.CSS
margin1 m = margin4 m m m m

margin2 :: Number -> Number -> CSS.CSS
margin2 v h = margin4 v h v h

marginLeft :: Number -> CSS.CSS
marginLeft m = CSS.marginLeft (CSS.rem m)

marginRight :: Number -> CSS.CSS
marginRight m = CSS.marginRight (CSS.rem m)

marginTop :: Number -> CSS.CSS
marginTop m = CSS.marginTop (CSS.rem m)

marginBottom :: Number -> CSS.CSS
marginBottom m = CSS.marginBottom (CSS.rem m)

borderRadius4 :: Number -> Number -> Number -> Number -> CSS.CSS
borderRadius4 tl tr br bl = CSS.borderRadius (CSS.rem tl) (CSS.rem tr) (CSS.rem br) (CSS.rem bl)

borderRadius1 :: Number -> CSS.CSS
borderRadius1 r = borderRadius4 r r r r

borderWidth :: Number -> CSS.CSS
borderWidth w = CSS.key (CSS.fromString "border-width") w

classSelect :: String -> CSS.CSS -> CSS.CSS
classSelect sel rs = CSS.select (CSS.fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 classSelect as .?

-- | The deep selector composer.
-- | Maps to `sel1 sel2` in CSS.
deepClass :: Selector -> String -> Selector
deepClass a b = CSSS.deep a (CSS.fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 deepClass as |*.

-- | The filter selector composer, adds a filter to a selector.
-- | Maps to something like `sel#filter`, `sel.filter` or `sel:filter` in CSS,
-- | depending on the filter.
classWith :: String -> Refinement -> Selector
classWith s r = CSSS.with (CSS.fromString $ "." <> stripDotPrefixFromClassName s) r

infix 6 classWith as .&

-- | See `with` 
classWithClass :: String -> String -> Selector
classWithClass s r = classWith s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 classWithClass as .&.

-- | See `with` 
withClass :: Selector -> String -> Selector
withClass s r = CSSS.with s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 withClass as &.

after :: Refinement
after = CSS.fromString "::after"

before :: Refinement
before = CSS.fromString "::before"

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