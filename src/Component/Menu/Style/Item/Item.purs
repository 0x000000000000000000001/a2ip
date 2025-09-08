module Component.Menu.Style.Item.Item
  ( class'
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
import Component.Menu.Style.Item.Icon.Container as IconContainer

classId :: String
classId = "fe61a278-61b4-4080-9122-482005b5b14a"

style :: CSS.CSS
style = do
  class' ? do
    color (graytone 0.9)
    display flex
    justifyContent center
    alignItems center
    cursor pointer
    padding (rem 0.7) (rem 0.0) (rem 0.7) (rem 0.0)

  hoverSel ? do
    backgroundColor ourRed

  hoverSel |* IconContainer.class' ? (IconContainer.boxShadow 0.22 (-0.10))

  where
  hoverSel = class' & hover