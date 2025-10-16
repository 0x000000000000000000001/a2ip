module Component.Router.Menu.Style.Menu
  ( classId
  , foldWidth
  , unfoldWidth
  , style
  , backgroundBlackAlpha
  ) where

import Proem hiding (top)

import CSS (alignItems, backgroundColor, borderRight, column, flexDirection, flexStart, height, hover, rem, rgba, solid, vh, zIndex)
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

style :: ∀ r. { isUnfold :: Boolean | r } -> CSS.CSS
style s = do
  classId .? do
    widthRem $ s.isUnfold ? unfoldWidth ↔ foldWidth
    backgroundColor (rgba 0 0 0 $ s.isUnfold ? backgroundBlackAlpha ↔ 0.3)
    positionFixed
    top0
    left0
    height (vh 100.0)
    borderRight solid (rem 0.2) (rgba 0 0 0 0.4)
    zIndex 1000
    displayFlex
    flexDirection column
    alignItems flexStart

  o_hover :? do 
    borderWidth 0.0

  where 
  o_hover = classId .& hover