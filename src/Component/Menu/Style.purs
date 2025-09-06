module Component.Menu.Style
  ( foldWidth
  , unfoldWidth
  , stylesheet
  , itemClass
  , itemClassName
  , itemIconClass
  , itemIconClassName
  , itemIconContainerClass
  , itemIconContainerClassName
  , logoClass
  , logoClassName
  , menuClass
  , menuClassName
  ) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, padding, position, rem, rgba, solid, top, vh, white, width, zIndex, (&), (?), (|*))
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import CSS.Cursor (pointer)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Component.Menu.Type (State)
import Data.NonEmpty (singleton)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS as HCSS
import Utils.Style (ourRed)

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

iconWidth :: Number
iconWidth = 3.2

menuClassName :: String
menuClassName = ".menu"

menuClass :: Selector
menuClass = CSS.fromString menuClassName

logoClassName :: String
logoClassName = menuClassName <> "__logo"

logoClass :: Selector
logoClass = CSS.fromString logoClassName

itemClassName :: String
itemClassName = menuClassName <> "__item"

itemClass :: Selector
itemClass = CSS.fromString itemClassName

itemIconContainerClassName :: String
itemIconContainerClassName = itemIconClassName <> "-container"

itemIconContainerClass :: Selector
itemIconContainerClass = CSS.fromString itemIconContainerClassName

itemIconClassName :: String
itemIconClassName = itemClassName <> "__icon"

itemIconClass :: Selector
itemIconClass = CSS.fromString itemIconClassName

logoStyle :: CSS.CSS
logoStyle = do
  logoClass ? do
    width (rem $ iconWidth * 1.2)
    margin (rem 1.4) (rem 1.0) (rem 1.0) (rem 1.0)
    key (fromString "filter") "invert(1)"
    cursor pointer
    alignSelf center

itemStyle :: CSS.CSS
itemStyle = do
  itemClass ? do
    color (graytone 0.9)
    display flex
    justifyContent center
    alignItems center
    cursor pointer
    padding (rem 0.7) (rem 0.0) (rem 0.7) (rem 0.0)

  hoverSel ? do
    backgroundColor ourRed

  hoverSel |* itemIconContainerClass ? (itemIconContainerBoxShadow 0.22 (-0.10))

  where
  hoverSel = itemClass & hover

itemIconStyle :: CSS.CSS
itemIconStyle = do
  itemIconClass ? do
    margin (rem 0.8) (rem 0.8) (rem 0.8) (rem 0.8)
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"

style :: State -> CSS.CSS
style s = do
  menuClass ? do
    width (rem if s.isUnfold then unfoldWidth else foldWidth)
    backgroundColor (rgba 0 0 0 if s.isUnfold then 0.85 else 0.3)
    position fixed
    top (rem 0.0)
    left (rem 0.0)
    height (vh 100.0)
    borderRight solid (rem 0.2) (rgba 0 0 0 0.4)
    zIndex 1000
    display flex
    flexDirection column
    alignItems flexStart
    overflow Overflow.hidden

stylesheet :: forall p i. State -> HTML p i
stylesheet s = HCSS.stylesheet do
  style s
  logoStyle
  itemStyle
  itemIconContainerStyle s
  itemIconStyle

itemIconContainerBoxShadow :: Number -> Number -> CSS.CSS
itemIconContainerBoxShadow x y = boxShadow $ singleton $ bsColor white $ shadow (rem x) (rem y)

itemIconContainerStyle :: State -> CSS.CSS
itemIconContainerStyle s = do
  itemIconContainerClass ? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadius (rem 5.0) (rem 5.0) (rem 5.0) (rem 5.0)
    minWidth (rem iconWidth)
    width (rem iconWidth)
    height (rem iconWidth)
    marginLeft (rem $ (foldWidth - iconWidth) / 2.0)
    display flex
    justifyContent center
    alignSelf center
    when s.isUnfold $ itemIconContainerBoxShadow 0.12 0.12