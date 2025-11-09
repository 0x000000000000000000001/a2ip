module App.Component.Common.Timeline.Style.Numbers
  ( staticClass
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
import Util.Style.Style (alignItemsCenter, displayFlex, reflectStaticClass, justifyContentCenter, leftPct50, positionAbsolute, topPct50, userSelectNone, (.?))
import Util.Style.Style as UtilStyle

staticClass :: String
staticClass = reflectStaticClass ι

fontSizePct :: Number 
fontSizePct = 110.0

translateXDelta :: Number
translateXDelta = -2.4

translate :: Number -> Transformation
translate xDelta = CSS.translate (rem xDelta) (pct $ -50.0)

style :: CSS.CSS
style = do
  staticClass .? do
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