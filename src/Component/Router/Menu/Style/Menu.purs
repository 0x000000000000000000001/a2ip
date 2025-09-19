module Component.Router.Menu.Style.Menu
  ( classId
  , foldWidth
  , unfoldWidth
  , style
  , backgroundBlackAlpha
  ) where

import Prelude hiding (top)

import CSS (alignItems, backgroundColor, borderRight, column, display, fixed, flex, flexDirection, flexStart, height, hover, left, position, rem, rgba, solid, top, vh, width, zIndex, (?))
import CSS as CSS
import Component.Router.Menu.Type (State)
import Utils.Style (borderWidth, (.&), (.?))

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

backgroundBlackAlpha ∷ Number
backgroundBlackAlpha = 0.85

classId :: String
classId = "AN5rFmTQb"

style :: State -> CSS.CSS
style s = do
  classId .? do
    width (rem if s.isUnfold then unfoldWidth else foldWidth)
    backgroundColor (rgba 0 0 0 if s.isUnfold then backgroundBlackAlpha else 0.3)
    position fixed
    top (rem 0.0)
    left (rem 0.0)
    height (vh 100.0)
    borderRight solid (rem 0.2) (rgba 0 0 0 0.4)
    zIndex 1000
    display flex
    flexDirection column
    alignItems flexStart

  o_hover ? do 
    borderWidth 0.0

  where 
  o_hover = classId .& hover