module Component.Common.Timeline.Style.Numbers
  ( classId
  , fontSizePct
  , style
  , translate
  , translateXDelta
  )
  where

import Proem hiding (top)

import CSS (Transformation, alignItems, color, column, flexDirection, justifyContent, pct, rem, transform)
import CSS as CSS
import CSS.Common (center)
import Color (darken)
import Component.Common.Timeline.Style.Util (grey)
import Util.Style (displayFlex, leftPct50, positionAbsolute, topPct50, userSelectNone, (.?))
import Util.Style as UtilStyle

classId :: String
classId = "ck6YcOjPV"

fontSizePct :: Number 
fontSizePct = 110.0

translateXDelta :: Number
translateXDelta = -2.4

translate :: Number -> Transformation
translate xDelta = CSS.translate (rem xDelta) (pct $ -50.0)

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    topPct50
    leftPct50
    transform $ translate translateXDelta
    displayFlex
    justifyContent center
    alignItems center
    flexDirection column
    UtilStyle.fontSizePct fontSizePct
    userSelectNone
    color $ darken 0.3 grey