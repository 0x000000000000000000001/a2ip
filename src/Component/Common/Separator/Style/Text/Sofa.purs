module Component.Common.Separator.Style.Text.Sofa
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (pct, transform, translate)
import CSS as CSS
import Component.Common.Separator.Style.Util (grey)
import Util.Style (fill, heightRem, leftPct50, positionAbsolute, top0, widthRem, (.?))

classId :: String
classId = "wQLJ9256h"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    top0
    leftPct50
    transform $ translate (pct $ -50.0) (pct $ -75.0)
    fill grey
    widthRem 4.0
    heightRem 4.0