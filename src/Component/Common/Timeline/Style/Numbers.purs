module Component.Common.Timeline.Style.Numbers
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, column, flexDirection, justifyContent, left, pct, rem, top, transform, translate)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, positionAbsolute, (.?))

classId :: String
classId = "ck6YcOjPV"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    top (pct 50.0)
    left (pct 50.0)
    transform $ translate (rem $ -2.4) (pct $ -50.0)
    displayFlex
    justifyContent center
    alignItems center
    flexDirection column