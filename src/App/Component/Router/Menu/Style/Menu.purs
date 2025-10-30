module App.Component.Router.Menu.Style.Menu
  ( backgroundBlackAlpha
  , classId
  , foldWidth
  , style
  , unfoldWidth
  , zIndex
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Type (State)
import CSS (alignItems, backgroundColor, borderRight, column, flexDirection, flexStart, height, hover, rem, rgba, solid, vh)
import CSS as CSS
import Util.Style (borderWidth, displayFlex, left0, positionFixed, top0, widthRem, (.&), (.?), (:?))

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

backgroundBlackAlpha ∷ Number
backgroundBlackAlpha = 0.85

classId :: String
classId = "AN5rFmTQb"

zIndex :: Int
zIndex = 1000

style :: State -> CSS.CSS
style s = do
  classId .? do
    widthRem $ s.unfold ? unfoldWidth ↔ foldWidth
    backgroundColor (rgba 0 0 0 $ s.unfold ? backgroundBlackAlpha ↔ 0.3)
    positionFixed
    top0
    left0
    height (vh 100.0)
    borderRight solid (rem 0.2) (rgba 0 0 0 0.4)
    CSS.zIndex zIndex
    displayFlex
    flexDirection column
    alignItems flexStart

  o_hover :? do 
    borderWidth 0.0

  where 
  o_hover = classId .& hover