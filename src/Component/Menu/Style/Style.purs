module Component.Menu.Style.Style
  ( class'
  , foldWidth
  , unfoldWidth
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

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

class' :: String
class' = ".menu"

style :: State -> CSS.CSS
style s = do
  class' ? do
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

sheet :: forall p i. State -> HTML p i
sheet s = HCSS.stylesheet do
  style s
  logosty
  itemStyle
  itemIconContainerStyle s
  itemIconStyle