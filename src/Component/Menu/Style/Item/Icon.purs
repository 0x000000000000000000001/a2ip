module Component.Menu.Style.Item.Icon
  ( class'
  , containerBoxShadow
  ) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, padding, position, rem, rgba, solid, top, vh, white, width, zIndex)
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
import Utils.Style (ourRed, (?), (|*), (&))

width :: Number
width = 3.2

class' :: String
class' = itemClass <> "__icon"

containerClass :: String
containerClass = class' <> "-container"

style :: CSS.CSS
style = do
  class' ? do
    margin (rem 0.8) (rem 0.8) (rem 0.8) (rem 0.8)
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"

containerBoxShadow :: Number -> Number -> CSS.CSS
containerBoxShadow x y = boxShadow $ singleton $ bsColor white $ shadow (rem x) (rem y)

containerStyle :: State -> CSS.CSS
containerStyle s = do
  containerClass ? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadius (rem 5.0) (rem 5.0) (rem 5.0) (rem 5.0)
    minWidth (rem iconWidth)
    width (rem iconWidth)
    height (rem iconWidth)
    marginLeft (rem $ (foldWidth - iconWidth) / 2.0)
    display flex
    justifyContent center
    alignSelf center
    when s.isUnfold $ containerBoxShadow 0.12 0.12