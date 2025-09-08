module Component.Menu.Style.Menu
  ( classId
  , foldWidth
  , unfoldWidth
  , style
  ) where

import Prelude hiding (top)

import CSS (alignItems, backgroundColor, borderRight, column, display, fixed, flex, flexDirection, flexStart, height, left, position, rem, rgba, solid, top, vh, width, zIndex)
import CSS as CSS
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Component.Menu.Type (State)
import Utils.Style ((?))

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

classId :: String
classId = "b7048b27-8d89-4f9e-bd71-6dda6fc4e9b9"

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