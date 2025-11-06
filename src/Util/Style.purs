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
  , borderRadiusPct50
  , borderRadiusRem1
  , borderRadiusRem4
  , borderWidth
  , bottom0
  , bottomCenterToBottomCenterWithRemDelta
  , bottomCenterToBottomLeftWithRemDelta
  , bottomCenterToBottomRightWithRemDelta
  , bottomCenterToCenterWithRemDelta
  , bottomCenterToCenterLeftWithRemDelta
  , bottomCenterToCenterRightWithRemDelta
  , bottomCenterToTopCenterWithRemDelta
  , bottomCenterToTopLeftWithRemDelta
  , bottomCenterToTopRightWithRemDelta
  , bottomLeftToBottomCenterWithRemDelta
  , bottomLeftToBottomLeftWithRemDelta
  , bottomLeftToBottomRightWithRemDelta
  , bottomLeftToCenterWithRemDelta
  , bottomLeftToCenterLeftWithRemDelta
  , bottomLeftToCenterRightWithRemDelta
  , bottomLeftToTopCenterWithRemDelta
  , bottomLeftToTopLeftWithRemDelta
  , bottomLeftToTopRightWithRemDelta
  , bottomPct
  , bottomPct100
  , bottomPct50
  , bottomRem
  , bottomRightToBottomCenterWithRemDelta
  , bottomRightToBottomLeftWithRemDelta
  , bottomRightToBottomRightWithRemDelta
  , bottomRightToCenterWithRemDelta
  , bottomRightToCenterLeftWithRemDelta
  , bottomRightToCenterRightWithRemDelta
  , bottomRightToTopCenterWithRemDelta
  , bottomRightToTopLeftWithRemDelta
  , bottomRightToTopRightWithRemDelta
  , centerLeftToBottomCenterWithRemDelta
  , centerLeftToBottomLeftWithRemDelta
  , centerLeftToBottomRightWithRemDelta
  , centerLeftToCenterWithRemDelta
  , centerLeftToCenterLeftWithRemDelta
  , centerLeftToCenterRightWithRemDelta
  , centerLeftToTopCenterWithRemDelta
  , centerLeftToTopLeftWithRemDelta
  , centerLeftToTopRightWithRemDelta
  , centerRightToBottomCenterWithRemDelta
  , centerRightToBottomLeftWithRemDelta
  , centerRightToBottomRightWithRemDelta
  , centerRightToCenterWithRemDelta
  , centerRightToCenterLeftWithRemDelta
  , centerRightToCenterRightWithRemDelta
  , centerRightToTopCenterWithRemDelta
  , centerRightToTopLeftWithRemDelta
  , centerRightToTopRightWithRemDelta
  , centerToBottomCenterWithRemDelta
  , centerToBottomLeftWithRemDelta
  , centerToBottomRightWithRemDelta
  , centerToCenterWithRemDelta
  , centerToCenterLeftWithRemDelta
  , centerToCenterRightWithRemDelta
  , centerToTopCenterWithRemDelta
  , centerToTopLeftWithRemDelta
  , centerToTopRightWithRemDelta
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
  , leftPct
  , leftPct100
  , leftPct50
  , leftRem
  , limegreen
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
  , onlyTranslateRem
  , overflowHidden
  , padding0
  , padding1
  , padding2
  , padding4
  , paddingBottom
  , paddingLeft
  , paddingRight
  , paddingTop
  , placeholder
  , pointerEventsNone
  , positionAbsolute
  , positionAbsoluteOnlyTranslatePct
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
  , refine
  , reflectHashModuleName
  , right0
  , rightPct
  , rightPct100
  , rightPct50
  , rightRem
  , svg
  , textAlignCenter
  , textRed
  , top0
  , topCenterToBottomCenterWithRemDelta
  , topCenterToBottomLeftWithRemDelta
  , topCenterToBottomRightWithRemDelta
  , topCenterToCenterWithRemDelta
  , topCenterToCenterLeftWithRemDelta
  , topCenterToCenterRightWithRemDelta
  , topCenterToTopCenterWithRemDelta
  , topCenterToTopLeftWithRemDelta
  , topCenterToTopRightWithRemDelta
  , topLeftToBottomCenterWithRemDelta
  , topLeftToBottomLeftWithRemDelta
  , topLeftToBottomRightWithRemDelta
  , topLeftToCenterWithRemDelta
  , topLeftToCenterLeftWithRemDelta
  , topLeftToCenterRightWithRemDelta
  , topLeftToTopCenterWithRemDelta
  , topLeftToTopLeftWithRemDelta
  , topLeftToTopRightWithRemDelta
  , topPct
  , topPct100
  , topPct50
  , topRem
  , topRightToBottomCenterWithRemDelta
  , topRightToBottomLeftWithRemDelta
  , topRightToBottomRightWithRemDelta
  , topRightToCenterWithRemDelta
  , topRightToCenterLeftWithRemDelta
  , topRightToCenterRightWithRemDelta
  , topRightToTopCenterWithRemDelta
  , topRightToTopLeftWithRemDelta
  , topRightToTopRightWithRemDelta
  , translatePct
  , translateRem
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

import Proem hiding (bottom, top)

import CSS (Refinement, Selector, StyleM, Transformation, absolute, alignItems, angular, animation, backgroundColor, backgroundImage, backgroundRepeat, backgroundSize, bold, borderColor, borderRadius, bottom, by, color, cursor, deg, display, fixed, flex, flexGrow, fontSize, fontWeight, forwards, fromString, height, infinite, inlineBlock, justifyContent, key, left, linear, linearGradient, margin, maxHeight, maxWidth, minHeight, minWidth, noRepeat, normalAnimationDirection, padding, pct, position, relative, rem, rgba, right, sec, select, selector, star, toHexString, top, transform, translate, width, wrap)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Common as CSSC
import CSS.Cursor (pointer)
import CSS.Overflow (hidden, overflow)
import CSS.Selector (child, deep, with)
import CSS.Size (calcSum)
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
import Util.Module (reflectCallingModuleName)

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

limegreen :: Color
limegreen = hsl 120.0 0.61 0.49

reflectHashModuleName :: Unit -> String
reflectHashModuleName = reflectCallingModuleName ▷ hash9

refine :: String -> String -> String 
refine classId with = hash9 $ classId <> "&" <> with

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

translateRem :: Number -> Number -> Transformation
translateRem x y = translate (rem x) (rem y)

onlyTranslatePct :: Number -> Number -> CSS.CSS 
onlyTranslatePct x y = transform $ translatePct x y

onlyTranslateRem :: Number -> Number -> CSS.CSS 
onlyTranslateRem x y = transform $ translateRem x y

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

pointerEventsNone :: CSS.CSS
pointerEventsNone = raw "pointer-events" "none"

positionAbsoluteOnlyTranslatePct :: Number -> Number -> CSS.CSS
positionAbsoluteOnlyTranslatePct x y = do
  positionAbsolute
  onlyTranslatePct x y

topLeftToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

topCenterToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

topRightToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerLeftToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerRightToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

bottomLeftToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomCenterToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomRightToTopLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToTopLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

topLeftToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

topCenterToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

topRightToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerLeftToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerRightToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

bottomLeftToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomCenterToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomRightToTopCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToTopCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

topLeftToTopRightWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

topCenterToTopRightWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

topRightToTopRightWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerLeftToTopRightWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerToTopRightWithRemDelta :: Number -> Number -> CSS.CSS
centerToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

centerRightToTopRightWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 0.0) (rem y)

bottomLeftToTopRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomCenterToTopRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomRightToTopRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToTopRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

topLeftToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

topCenterToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

topRightToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerLeftToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerRightToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

bottomLeftToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomCenterToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomRightToCenterLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToCenterLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

topLeftToCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

topCenterToCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

topRightToCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerLeftToCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerToCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerRightToCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

bottomLeftToCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomCenterToCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomRightToCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

topLeftToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

topCenterToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

topRightToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerLeftToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS
centerToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

centerRightToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 50.0) (rem y)

bottomLeftToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomCenterToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

bottomRightToCenterRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToCenterRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 100.0) (rem y)

topLeftToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

topCenterToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

topRightToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerLeftToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerRightToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

bottomLeftToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

bottomCenterToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

bottomRightToBottomLeftWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToBottomLeftWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

topLeftToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

topCenterToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topCenterToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

topRightToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS 
topRightToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerLeftToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerRightToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 50.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

bottomLeftToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

bottomCenterToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

bottomRightToBottomCenterWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToBottomCenterWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 50.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

topLeftToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS 
topLeftToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

topCenterToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
topCenterToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

topRightToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
topRightToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerLeftToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
centerLeftToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
centerToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) (-50.0)
  left $ calcSum (pct 100.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

centerRightToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
centerRightToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 (-50.0)
  right $ calcSum (pct 0.0) (rem x)
  top $ calcSum (pct 100.0) (rem y)

bottomLeftToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomLeftToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  left $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

bottomCenterToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomCenterToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct (-50.0) 0.0
  left $ calcSum (pct 100.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

bottomRightToBottomRightWithRemDelta :: Number -> Number -> CSS.CSS
bottomRightToBottomRightWithRemDelta x y = do
  positionAbsoluteOnlyTranslatePct 0.0 0.0
  right $ calcSum (pct 0.0) (rem x)
  bottom $ calcSum (pct 0.0) (rem y)

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

borderRadiusPct50 :: CSS.CSS
borderRadiusPct50 = borderRadiusPct1 50.0

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

placeholder :: Refinement
placeholder = fromString "::placeholder"

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