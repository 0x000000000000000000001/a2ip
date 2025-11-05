module App.Component.Common.Timeline.Style.Numbers
  ( classId
  , fontSizePct
  , style
  , translate
  , translateXDelta
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS (Transformation, color, column, flexDirection, pct, rem, transform)
import CSS as CSS
import Color (darken)
import Util.Style (alignItemsCenter, displayFlex, reflectHashModuleName, justifyContentCenter, leftPct50, positionAbsolute, topPct50, userSelectNone, (.?))
import Util.Style as UtilStyle

classId :: String
classId = reflectHashModuleName ι

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
    justifyContentCenter
    alignItemsCenter
    flexDirection column
    UtilStyle.fontSizePct fontSizePct
    userSelectNone
    color $ darken 0.3 grey