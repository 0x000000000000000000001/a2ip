module Component.Common.Timeline.Style.Numbers
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, column, flexDirection, justifyContent, pct, rem, transform, translate)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, leftPct50, positionAbsolute, topPct50, (.?))

classId :: String
classId = "ck6YcOjPV"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    topPct50
    leftPct50
    transform $ translate (rem $ -2.4) (pct $ -50.0)
    displayFlex
    justifyContent center
    alignItems center
    flexDirection column