module Component.Common.Timeline.Style.Line
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, pct, transform)
import CSS as CSS
import CSS.Transform (translateX)
import Component.Common.Timeline.Style.Util (grey)
import Util.Style (borderRadius1, heightPct100, leftPct50, positionAbsolute, top0, widthRem, (.?))

classId :: String
classId = "wN3cW8fkU"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    top0
    leftPct50
    transform $ translateX $ pct $ -50.0
    widthRem 0.24
    borderRadius1 1.0
    backgroundColor grey
    heightPct100