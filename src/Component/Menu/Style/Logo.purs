module Component.Menu.Style.Logo
  ( class'
  )
  where

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
import Component.Menu.Style.Style (iconWidth, class')

class' :: String
class' = class' <> "__logo"

style :: CSS.CSS
style = do
  class' ? do
    width (rem $ iconWidth * 1.2)
    margin (rem 1.4) (rem 1.0) (rem 1.0) (rem 1.0)
    key (fromString "filter") "invert(1)"
    cursor pointer
    alignSelf center