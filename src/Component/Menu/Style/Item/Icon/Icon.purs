module Component.Menu.Style.Item.Icon.Icon
  ( class'
  , containerBoxShadow
  , containerClass
  , containerStyle
  , style
  , width
  ) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, padding, position, rem, rgba, solid, top, vh, white, zIndex)
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import CSS.Cursor (pointer)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Component.Menu.Style.Menu as MenuStyle
import Component.Menu.Type (State)
import Data.NonEmpty (singleton)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS as HCSS
import Utils.Style (ourRed, (?), (|*), (&))

width :: Number
width = 3.2

classId :: String
classId = "c093a814-b70b-4ef6-941a-79b79959f3e4"

style :: CSS.CSS
style = do
  class' ? do
    margin (rem 0.8) (rem 0.8) (rem 0.8) (rem 0.8)
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"