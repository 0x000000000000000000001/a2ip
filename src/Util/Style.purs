module Util.Style
  ( (&.)
  , (&:)
  , (&¨)
  , (.&)
  , (.&.)
  , (.&:)
  , (.&¨)
  , (.?)
  , (.|*)
  , (.|*.)
  , (.|*:)
  , (.|*¨)
  , (.|>)
  , (.|>.)
  , (.|>:)
  , (.|>¨)
  , (:&)
  , (:&.)
  , (:&:)
  , (:&¨)
  , (:?)
  , (:|*.)
  , (:|*:)
  , (:|*¨)
  , (:|>)
  , (:|>.)
  , (:|>:)
  , (:|>¨)
  , (|*.)
  , (|*:)
  , (|*¨)
  , (|>.)
  , (|>:)
  , (|>¨)
  , (¨&)
  , (¨&.)
  , (¨&:)
  , (¨&¨)
  , (¨?)
  , (¨|*)
  , (¨|*.)
  , (¨|*:)
  , (¨|>)
  , (¨|>.)
  , (¨|>:)
  , (¨|>¨)
  , after
  , alignItemsCenter
  , all
  , any
  , backgroundColorRed
  , backgroundColorTransparent
  , backgroundColorWhite
  , backgroundWhite
  , before
  , borderRadiusPct1
  , borderRadiusPct4
  , borderRadiusRem1
  , borderRadiusRem4
  , borderWidth
  , bottom0
  , bottomCenterToBottomCenter
  , bottomCenterToBottomLeft
  , bottomCenterToBottomRight
  , bottomCenterToCenter
  , bottomCenterToCenterLeft
  , bottomCenterToCenterRight
  , bottomCenterToTopCenter
  , bottomCenterToTopLeft
  , bottomCenterToTopRight
  , bottomLeftToBottomCenter
  , bottomLeftToBottomLeft
  , bottomLeftToBottomRight
  , bottomLeftToCenter
  , bottomLeftToCenterLeft
  , bottomLeftToCenterRight
  , bottomLeftToTopCenter
  , bottomLeftToTopLeft
  , bottomLeftToTopRight
  , bottomPct100
  , bottomPct50
  , bottomRem
  , bottomRightToBottomCenter
  , bottomRightToBottomLeft
  , bottomRightToBottomRight
  , bottomRightToCenter
  , bottomRightToCenterLeft
  , bottomRightToCenterRight
  , bottomRightToTopCenter
  , bottomRightToTopLeft
  , bottomRightToTopRight
  , centerLeftToBottomCenter
  , centerLeftToBottomLeft
  , centerLeftToBottomRight
  , centerLeftToCenter
  , centerLeftToCenterLeft
  , centerLeftToCenterRight
  , centerLeftToTopCenter
  , centerLeftToTopLeft
  , centerLeftToTopRight
  , centerRightToBottomCenter
  , centerRightToBottomLeft
  , centerRightToBottomRight
  , centerRightToCenter
  , centerRightToCenterLeft
  , centerRightToCenterRight
  , centerRightToTopCenter
  , centerRightToTopLeft
  , centerRightToTopRight
  , centerToBottomCenter
  , centerToBottomLeft
  , centerToBottomRight
  , centerToCenter
  , centerToCenterLeft
  , centerToCenterRight
  , centerToTopCenter
  , centerToTopLeft
  , centerToTopRight
  , classChildClass
  , classChildRaw
  , classChildTyped
  , classDeepClass
  , classDeepRaw
  , classDeepTyped
  , classSelect
  , classWithClass
  , classWithRaw
  , classWithTyped
  , class_
  , classes
  , colorRed
  , content
  , cursorPointer
  , displayFlex
  , displayInlineBlock
  , displayNone
  , fill
  , flexGrow1
  , flexWrap
  , focus
  , fontSizePct
  , fontSizeRem
  , fontWeightBold
  , getRootFontSize
  , has
  , hash9
  , heightPct
  , heightPct100
  , heightRem
  , justifyContentCenter
  , left0
  , leftPct100
  , leftPct50
  , leftRem
  , loading
  , loadingGrey
  , loadingShimmerAnimationId
  , loadingShimmerWidth
  , margin0
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
  , onlyTranslatePct
  , overflowHidden
  , padding0
  , padding1
  , padding2
  , padding4
  , paddingBottom
  , paddingLeft
  , paddingRight
  , paddingTop
  , positionAbsolute
  , positionAbsoluteTranslatePct
  , positionFixed
  , positionRelative
  , positionSticky
  , raw
  , rawChildClass
  , rawChildRaw
  , rawChildTyped
  , rawDeepClass
  , rawDeepTyped
  , rawSelect
  , rawWithClass
  , rawWithRaw
  , rawWithTyped
  , red
  , right0
  , rightPct100
  , rightPct50
  , rightRem
  , svg
  , textAlignCenter
  , textRed
  , top0
  , topCenterToBottomCenter
  , topCenterToBottomLeft
  , topCenterToBottomRight
  , topCenterToCenter
  , topCenterToCenterLeft
  , topCenterToCenterRight
  , topCenterToTopCenter
  , topCenterToTopLeft
  , topCenterToTopRight
  , topLeftToBottomCenter
  , topLeftToBottomLeft
  , topLeftToBottomRight
  , topLeftToCenter
  , topLeftToCenterLeft
  , topLeftToCenterRight
  , topLeftToTopCenter
  , topLeftToTopLeft
  , topLeftToTopRight
  , topPct
  , topPct100
  , topPct50
  , topRem
  , topRightToBottomCenter
  , topRightToBottomLeft
  , topRightToBottomRight
  , topRightToCenter
  , topRightToCenterLeft
  , topRightToCenterRight
  , topRightToTopCenter
  , topRightToTopLeft
  , topRightToTopRight
  , translatePct
  , transparent
  , typedChildClass
  , typedChildRaw
  , typedDeepClass
  , typedDeepRaw
  , typedWithClass
  , typedWithRaw
  , userSelectNone
  , widthPct
  , widthPct100
  , widthRem
  )
  where

import Proem hiding (top, bottom, div)

import CSS (Refinement, Selector, StyleM, Transformation, absolute, alignItems, angular, animation, backgroundColor, backgroundImage, backgroundRepeat, backgroundSize, bold, borderColor, borderRadius, bottom, by, color, cursor, deg, display, fixed, flex, flexGrow, fontSize, fontWeight, forwards, fromString, height, infinite, inlineBlock, justifyContent, key, left, linear, linearGradient, margin, maxHeight, maxWidth, minHeight, minWidth, noRepeat, normalAnimationDirection, padding, pct, position, relative, rem, rgba, right, sec, select, selector, star, toHexString, top, transform, translate, width, wrap)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Common as CSSC
import CSS.Cursor (pointer)
import CSS.Overflow (hidden, overflow)
import CSS.Selector (child, deep, with)
import CSS.TextAlign (textAlign, center)
import Color (darken)
import Data.Array (foldl, (!!))
import Data.Char (toCharCode)
import Data.Int as Int
import Data.String (Pattern(..), stripPrefix)
import Data.String.CodeUnits (toCharArray, fromCharArray)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Halogen.HTML (ClassName(..), IProp)
import Halogen.HTML.Properties as HP

foreign import getRootFontSize :: Effect Number

red :: Color
red = hsl 353.91 0.8174 0.4725

textRed :: Color
textRed = darken 0.1 red

colorRed :: CSS.CSS
colorRed = color textRed

loadingGrey :: Color
loadingGrey = hsl 0.0 0.0 0.9

backgroundWhite :: Color
backgroundWhite = hsl 196.0 1.0 0.98

-- | Utility function to set the class attribute on an HTML element.
-- | It automatically removes any "." prefix from the class name.
class_ :: ∀ r i. String -> IProp (class :: String | r) i
class_ className = HP.class_ $ ClassName $ stripDotPrefixFromClassName className

classes :: ∀ r i. Array String -> IProp (class :: String | r) i
classes classNames = HP.classes $ ClassName <$> (stripDotPrefixFromClassName <$> classNames)

stripDotPrefixFromClassName :: String -> String
stripDotPrefixFromClassName className = (stripPrefix (Pattern ".") className) ??⇒ className

raw :: String -> String -> CSS.CSS
raw k v = key (fromString k) v

nothing :: CSS.CSS
nothing = ηι

translatePct :: Number -> Number -> Transformation
translatePct x y = translate (pct x) (pct y)

onlyTranslatePct :: Number -> Number -> CSS.CSS 
onlyTranslatePct x y = transform $ translatePct x y

textAlignCenter :: CSS.CSS 
textAlignCenter = textAlign center

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

positionSticky :: CSS.CSS
positionSticky = raw "position" "sticky"

topRem :: Number -> CSS.CSS
topRem t = top (rem t)

topPct :: Number -> CSS.CSS
topPct t = top (pct t)

leftRem :: Number -> CSS.CSS
leftRem l = left (rem l)

leftPct :: Number -> CSS.CSS
leftPct l = left (pct l)

bottomRem :: Number -> CSS.CSS
bottomRem b = bottom (rem b)

bottomPct :: Number -> CSS.CSS
bottomPct b = bottom (pct b)

rightRem :: Number -> CSS.CSS
rightRem r = right (rem r)

rightPct :: Number -> CSS.CSS
rightPct r = right (pct r)

top0 :: CSS.CSS
top0 = topRem 0.0

topPct50 :: CSS.CSS
topPct50 = topPct 50.0

topPct100 :: CSS.CSS
topPct100 = topPct 100.0

left0 :: CSS.CSS
left0 = leftRem 0.0

leftPct50 :: CSS.CSS
leftPct50 = leftPct 50.0

leftPct100 :: CSS.CSS
leftPct100 = leftPct 100.0

bottom0 :: CSS.CSS
bottom0 = bottomRem 0.0

bottomPct50 :: CSS.CSS
bottomPct50 = bottomPct 50.0

bottomPct100 :: CSS.CSS
bottomPct100 = bottomPct 100.0

right0 :: CSS.CSS
right0 = rightRem 0.0

rightPct50 :: CSS.CSS
rightPct50 = rightPct 50.0

rightPct100 :: CSS.CSS
rightPct100 = rightPct 100.0

overflowHidden :: CSS.CSS
overflowHidden = overflow hidden

flexWrap :: CSS.CSS
flexWrap = CSS.flexWrap wrap

flexGrow1 :: CSS.CSS
flexGrow1 = flexGrow 1.0

fontSizePct :: Number -> CSS.CSS
fontSizePct p = fontSize (pct p)

fontSizeRem :: Number -> CSS.CSS
fontSizeRem r = fontSize (rem r)

fontWeightBold :: CSS.CSS
fontWeightBold = fontWeight bold

loadingShimmerAnimationId :: String
loadingShimmerAnimationId = "BoE6IFJ8r"

loadingShimmerWidth :: Number
loadingShimmerWidth = 12.5

loading :: StyleM Unit
loading = do 
  backgroundColor loadingGrey
  borderColor transparent
  color transparent
  backgroundImage $ linearGradient (angular $ deg 90.0) [
    transparent /\ pct 0.0,
    rgba 255 255 255 0.5 /\ pct 50.0,
    transparent /\ pct 100.0
  ]
  backgroundSize $ by (rem loadingShimmerWidth) (pct 100.0)
  backgroundRepeat noRepeat
  animation 
    (fromString loadingShimmerAnimationId) 
    (sec 0.7)
    linear
    (sec 0.0)
    infinite
    normalAnimationDirection
    forwards

content :: String -> CSS.CSS
content s = raw "content" $ "\"" <> s <> "\""

backgroundColorRed :: CSS.CSS
backgroundColorRed = backgroundColor red

backgroundColorWhite :: CSS.CSS
backgroundColorWhite = backgroundColor backgroundWhite

backgroundColorTransparent :: CSS.CSS
backgroundColorTransparent = backgroundColor transparent

transparent :: Color
transparent = rgba 0 0 0 0.0

displayInlineBlock :: CSS.CSS
displayInlineBlock = display inlineBlock

displayFlex :: CSS.CSS
displayFlex = display flex

justifyContentCenter :: CSS.CSS
justifyContentCenter = justifyContent CSSC.center

alignItemsCenter :: CSS.CSS
alignItemsCenter = alignItems CSSC.center

cursorPointer :: CSS.CSS
cursorPointer = cursor pointer

positionAbsoluteTranslatePct :: Number -> Number -> CSS.CSS
positionAbsoluteTranslatePct x y = do
  positionAbsolute
  onlyTranslatePct x y

topLeftToTopLeft :: CSS.CSS 
topLeftToTopLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  left0
  top0

topCenterToTopLeft :: CSS.CSS 
topCenterToTopLeft = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  left0
  top0

topRightToTopLeft :: CSS.CSS 
topRightToTopLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct100
  top0

centerLeftToTopLeft :: CSS.CSS
centerLeftToTopLeft = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  left0
  top0

centerToTopLeft :: CSS.CSS
centerToTopLeft = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  left0
  top0

centerRightToTopLeft :: CSS.CSS
centerRightToTopLeft = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  rightPct100
  top0

bottomLeftToTopLeft :: CSS.CSS
bottomLeftToTopLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  left0
  bottomPct100

bottomCenterToTopLeft :: CSS.CSS
bottomCenterToTopLeft = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  left0
  bottomPct100

bottomRightToTopLeft :: CSS.CSS
bottomRightToTopLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct100
  bottomPct100

topLeftToTopCenter :: CSS.CSS 
topLeftToTopCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct50
  top0

topCenterToTopCenter :: CSS.CSS 
topCenterToTopCenter = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct50
  top0

topRightToTopCenter :: CSS.CSS 
topRightToTopCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct50
  top0

centerLeftToTopCenter :: CSS.CSS
centerLeftToTopCenter = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  leftPct50
  top0

centerToTopCenter :: CSS.CSS
centerToTopCenter = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  leftPct50
  top0

centerRightToTopCenter :: CSS.CSS
centerRightToTopCenter = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  rightPct50
  top0

bottomLeftToTopCenter :: CSS.CSS
bottomLeftToTopCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct50
  bottomPct100

bottomCenterToTopCenter :: CSS.CSS
bottomCenterToTopCenter = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct50
  bottomPct100

bottomRightToTopCenter :: CSS.CSS
bottomRightToTopCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct50
  bottomPct100

topLeftToTopRight :: CSS.CSS 
topLeftToTopRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct100
  top0

topCenterToTopRight :: CSS.CSS 
topCenterToTopRight = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct100
  top0

topRightToTopRight :: CSS.CSS 
topRightToTopRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  right0
  top0

centerLeftToTopRight :: CSS.CSS
centerLeftToTopRight = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  leftPct100
  top0

centerToTopRight :: CSS.CSS
centerToTopRight = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  leftPct100
  top0

centerRightToTopRight :: CSS.CSS
centerRightToTopRight = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  right0
  top0

bottomLeftToTopRight :: CSS.CSS
bottomLeftToTopRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct100
  bottomPct100

bottomCenterToTopRight :: CSS.CSS
bottomCenterToTopRight = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct100
  bottomPct100

bottomRightToTopRight :: CSS.CSS
bottomRightToTopRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  right0
  bottomPct100

topLeftToCenterLeft :: CSS.CSS 
topLeftToCenterLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  left0
  topPct50

topCenterToCenterLeft :: CSS.CSS 
topCenterToCenterLeft = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  left0
  topPct50

topRightToCenterLeft :: CSS.CSS 
topRightToCenterLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct100
  topPct50

centerLeftToCenterLeft :: CSS.CSS
centerLeftToCenterLeft = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  left0
  topPct50

centerToCenterLeft :: CSS.CSS
centerToCenterLeft = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  left0
  topPct50

centerRightToCenterLeft :: CSS.CSS
centerRightToCenterLeft = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  rightPct100
  topPct50

bottomLeftToCenterLeft :: CSS.CSS
bottomLeftToCenterLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  left0
  bottomPct100

bottomCenterToCenterLeft :: CSS.CSS
bottomCenterToCenterLeft = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  left0
  bottomPct100

bottomRightToCenterLeft :: CSS.CSS
bottomRightToCenterLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct100
  bottomPct100

topLeftToCenter :: CSS.CSS 
topLeftToCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct50
  topPct50

topCenterToCenter :: CSS.CSS 
topCenterToCenter = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct50
  topPct50

topRightToCenter :: CSS.CSS 
topRightToCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct50
  topPct50

centerLeftToCenter :: CSS.CSS
centerLeftToCenter = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  leftPct50
  topPct50

centerToCenter :: CSS.CSS
centerToCenter = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  leftPct50
  topPct50

centerRightToCenter :: CSS.CSS
centerRightToCenter = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  rightPct50
  topPct50

bottomLeftToCenter :: CSS.CSS
bottomLeftToCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct50
  bottomPct100

bottomCenterToCenter :: CSS.CSS
bottomCenterToCenter = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct50
  bottomPct100

bottomRightToCenter :: CSS.CSS
bottomRightToCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct50
  bottomPct100

topLeftToCenterRight :: CSS.CSS 
topLeftToCenterRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct100
  topPct50

topCenterToCenterRight :: CSS.CSS 
topCenterToCenterRight = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct100
  topPct50

topRightToCenterRight :: CSS.CSS 
topRightToCenterRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  right0
  topPct50

centerLeftToCenterRight :: CSS.CSS
centerLeftToCenterRight = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  leftPct100
  topPct50

centerToCenterRight :: CSS.CSS
centerToCenterRight = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  leftPct100
  topPct50

centerRightToCenterRight :: CSS.CSS
centerRightToCenterRight = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  right0
  topPct50

bottomLeftToCenterRight :: CSS.CSS
bottomLeftToCenterRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct100
  bottomPct100

bottomCenterToCenterRight :: CSS.CSS
bottomCenterToCenterRight = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct100
  bottomPct100

bottomRightToCenterRight :: CSS.CSS
bottomRightToCenterRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  right0
  bottomPct100

topLeftToBottomLeft :: CSS.CSS 
topLeftToBottomLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  left0
  topPct100

topCenterToBottomLeft :: CSS.CSS 
topCenterToBottomLeft = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  left0
  topPct100

topRightToBottomLeft :: CSS.CSS 
topRightToBottomLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct100
  topPct100

centerLeftToBottomLeft :: CSS.CSS
centerLeftToBottomLeft = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  left0
  topPct100

centerToBottomLeft :: CSS.CSS
centerToBottomLeft = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  left0
  topPct100

centerRightToBottomLeft :: CSS.CSS
centerRightToBottomLeft = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  rightPct100
  topPct100

bottomLeftToBottomLeft :: CSS.CSS
bottomLeftToBottomLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  left0
  bottom0

bottomCenterToBottomLeft :: CSS.CSS
bottomCenterToBottomLeft = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  left0
  bottom0

bottomRightToBottomLeft :: CSS.CSS
bottomRightToBottomLeft = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct100
  bottom0

topLeftToBottomCenter :: CSS.CSS 
topLeftToBottomCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct50
  topPct100

topCenterToBottomCenter :: CSS.CSS 
topCenterToBottomCenter = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct50
  topPct100

topRightToBottomCenter :: CSS.CSS 
topRightToBottomCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct50
  topPct100

centerLeftToBottomCenter :: CSS.CSS
centerLeftToBottomCenter = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  leftPct50
  topPct100

centerToBottomCenter :: CSS.CSS
centerToBottomCenter = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  leftPct50
  topPct100

centerRightToBottomCenter :: CSS.CSS
centerRightToBottomCenter = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  rightPct50
  topPct100

bottomLeftToBottomCenter :: CSS.CSS
bottomLeftToBottomCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct50
  bottom0

bottomCenterToBottomCenter :: CSS.CSS
bottomCenterToBottomCenter = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct50
  bottom0

bottomRightToBottomCenter :: CSS.CSS
bottomRightToBottomCenter = do
  positionAbsoluteTranslatePct 0.0 0.0
  rightPct50
  bottom0

topLeftToBottomRight :: CSS.CSS 
topLeftToBottomRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct100
  topPct100

topCenterToBottomRight :: CSS.CSS
topCenterToBottomRight = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct100
  topPct100

topRightToBottomRight :: CSS.CSS
topRightToBottomRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  right0
  topPct100

centerLeftToBottomRight :: CSS.CSS
centerLeftToBottomRight = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  leftPct100
  topPct100

centerToBottomRight :: CSS.CSS
centerToBottomRight = do
  positionAbsoluteTranslatePct (-50.0) (-50.0)
  leftPct100
  topPct100

centerRightToBottomRight :: CSS.CSS
centerRightToBottomRight = do
  positionAbsoluteTranslatePct 0.0 (-50.0)
  right0
  topPct100

bottomLeftToBottomRight :: CSS.CSS
bottomLeftToBottomRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  leftPct100
  bottom0

bottomCenterToBottomRight :: CSS.CSS
bottomCenterToBottomRight = do
  positionAbsoluteTranslatePct (-50.0) 0.0
  leftPct100
  bottom0

bottomRightToBottomRight :: CSS.CSS
bottomRightToBottomRight = do
  positionAbsoluteTranslatePct 0.0 0.0
  right0
  bottom0

fill :: Color -> CSS.CSS
fill c = raw "fill" $ toHexString c

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

heightPct100 :: CSS.CSS
heightPct100 = heightPct 100.0

minHeightRem :: Number -> CSS.CSS
minHeightRem h = minHeight (rem h)

minHeightPct :: Number -> CSS.CSS
minHeightPct h = minHeight (pct h)

maxHeightRem :: Number -> CSS.CSS
maxHeightRem h = maxHeight (rem h)

maxHeightPct :: Number -> CSS.CSS
maxHeightPct h = maxHeight (pct h)

padding0 :: CSS.CSS
padding0 = padding1 0.0

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

margin0 :: CSS.CSS
margin0 = margin1 0.0

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

borderRadiusRem4 :: Number -> Number -> Number -> Number -> CSS.CSS
borderRadiusRem4 tl tr br bl = borderRadius (rem tl) (rem tr) (rem br) (rem bl)

borderRadiusRem1 :: Number -> CSS.CSS
borderRadiusRem1 r = borderRadiusRem4 r r r r

borderRadiusPct4 :: Number -> Number -> Number -> Number -> CSS.CSS
borderRadiusPct4 tl tr br bl = borderRadius (pct tl) (pct tr) (pct br) (pct bl)

borderRadiusPct1 :: Number -> CSS.CSS
borderRadiusPct1 r = borderRadiusPct4 r r r r

borderWidth :: Number -> CSS.CSS
borderWidth w = raw "border-width" $ show w

any :: Selector
any = star

all :: Selector
all = star

svg :: Selector
svg = fromString "svg"

infixr 5 select as :?

classSelect :: String -> CSS.CSS -> CSS.CSS
classSelect sel rs = select (fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 classSelect as .?

rawSelect :: String -> CSS.CSS -> CSS.CSS
rawSelect sel rs = select (fromString sel) rs

infixr 5 rawSelect as ¨?

infix 6 child as :|>:
infix 6 child as :|>
infix 6 child as |>:

classChildTyped :: String -> Selector -> Selector
classChildTyped a b = child (fromString $ "." <> stripDotPrefixFromClassName a) b

infix 6 classChildTyped as .|>
infix 6 classChildTyped as .|>:

rawChildTyped :: String -> Selector -> Selector
rawChildTyped a b = child (fromString a) b

infix 6 rawChildTyped as ¨|>
infix 6 rawChildTyped as ¨|>:

typedChildClass :: Selector -> String -> Selector
typedChildClass a b = child a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 typedChildClass as |>.
infix 6 typedChildClass as :|>.

typedChildRaw :: Selector -> String -> Selector
typedChildRaw a b = child a (fromString b)

infix 6 typedChildRaw as |>¨
infix 6 typedChildRaw as :|>¨

rawChildClass :: Selector -> String -> Selector
rawChildClass a b = child a (fromString b)

infix 6 rawChildClass as ¨|>.

rawChildRaw :: String -> String -> Selector
rawChildRaw a b = child (fromString a) (fromString b)

infix 6 rawChildRaw as ¨|>¨

classChildClass :: String -> String -> Selector
classChildClass a b = classChildTyped a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 classChildClass as .|>.

classChildRaw :: String -> String -> Selector
classChildRaw a b = classChildTyped a (fromString b)

infix 6 classChildRaw as .|>¨

infix 6 deep as :|*:
infix 6 deep as :|*
infix 6 deep as |*:

classDeepTyped :: String -> Selector -> Selector
classDeepTyped a b = deep (fromString $ "." <> stripDotPrefixFromClassName a) b

infix 6 classDeepTyped as .|*
infix 6 classDeepTyped as .|*:

rawDeepTyped :: String -> Selector -> Selector
rawDeepTyped a b = deep (fromString a) b

infix 6 rawDeepTyped as ¨|*
infix 6 rawDeepTyped as ¨|*:

typedDeepRaw :: Selector -> String -> Selector
typedDeepRaw a b = deep a (fromString b)

infix 6 typedDeepRaw as |*¨
infix 6 typedDeepRaw as :|*¨

classDeepRaw :: String -> String -> Selector
classDeepRaw a b = classDeepTyped a (fromString b)

infix 6 classDeepRaw as .|*¨

typedDeepClass :: Selector -> String -> Selector
typedDeepClass a b = deep a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 typedDeepClass as |*.
infix 6 typedDeepClass as :|*.

rawDeepClass :: String -> String -> Selector
rawDeepClass a b = typedDeepClass (fromString a) b

infix 6 rawDeepClass as ¨|*.

classDeepClass :: String -> String -> Selector
classDeepClass a b = classDeepTyped a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 classDeepClass as .|*.

rawDeepRaw :: String -> String -> Selector
rawDeepRaw a b = deep (fromString a) (fromString b)

infix 6 rawDeepRaw as ¨|*¨

infix 6 with as :&:
infix 6 with as :&
infix 6 with as &:

classWithTyped :: String -> Refinement -> Selector
classWithTyped a b = with (fromString $ "." <> stripDotPrefixFromClassName a) b

infix 6 classWithTyped as .&
infix 6 classWithTyped as .&:

classWithRaw :: String -> String -> Selector
classWithRaw a b = classWithTyped a (fromString b)

infix 6 classWithRaw as .&¨

typedWithClass :: Selector -> String -> Selector
typedWithClass a b = with a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 typedWithClass as &.
infix 6 typedWithClass as :&.

rawWithClass :: String -> String -> Selector
rawWithClass a b = typedWithClass (fromString a) b

infix 6 rawWithClass as ¨&.

rawWithTyped :: String -> Refinement -> Selector
rawWithTyped a b = with (fromString a) b

infix 6 rawWithTyped as ¨&
infix 6 rawWithTyped as ¨&:

typedWithRaw :: Selector -> String -> Selector
typedWithRaw a b = with a (fromString b)

infix 6 typedWithRaw as &¨
infix 6 typedWithRaw as :&¨

rawWithRaw :: String -> String -> Selector
rawWithRaw a b = with (fromString a) (fromString b)

infix 6 rawWithRaw as ¨&¨

classWithClass :: String -> String -> Selector
classWithClass a b = classWithTyped a (fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 classWithClass as .&.

focus :: Refinement
focus = fromString ":focus"

after :: Refinement
after = fromString "::after"

before :: Refinement
before = fromString "::before"

has :: Selector -> Refinement
has sel = fromString $ ":has(" <> selector sel <> ")"

-- | Fast polynomial hash function that generates a 9-character identifier
-- | Perfect for CSS class names with very low collision probability
hash9 :: ∀ a. Show a => a -> String
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
      chars !! (n `Int.rem` 62)
        ?? (\c -> fromCharArray [c])
        ⇔ "o"

    -- Extract letter for first char
    getLetter :: Int -> String
    getLetter n = 
      letters !! (n `Int.rem` 52)
        ?? (\c -> fromCharArray [c])
        ⇔ "A"
        
  in
  -- Use different positions from each hash for better distribution
  getLetter hash1 <>
  getChar (hash1 / 62) <> getChar (hash1 / 3844) <>
  getChar hash2 <> getChar (hash2 / 62) <> getChar (hash2 / 3844) <>
  getChar hash3 <> getChar (hash3 / 62) <> getChar (hash3 / 3844)