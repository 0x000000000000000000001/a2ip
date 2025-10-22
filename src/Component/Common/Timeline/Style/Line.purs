module Component.Common.Timeline.Style.Line
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor)
import CSS as CSS
import Component.Common.Timeline.Style.Util (grey)
import Util.Style (borderRadius1, heightPct100, topCenterToTopCenter, widthRem, (.?))

classId :: String
classId = "wN3cW8fkU"

style :: CSS.CSS
style = do
  classId .? do
    topCenterToTopCenter
    widthRem 0.24
    borderRadius1 1.0
    backgroundColor grey
    heightPct100