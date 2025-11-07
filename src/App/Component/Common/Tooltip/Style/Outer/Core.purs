module App.Component.Common.Tooltip.Style.Outer.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, color, rgba, white)
import CSS as CSS
import Util.Style.Style (borderRadiusRem1, overflowHidden, padding1, reflectHashModuleName, userSelectNone, widthPct100, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    backgroundColor $ rgba 0 0 0 0.9
    color white
    padding1 1.0
    userSelectNone
    borderRadiusRem1 0.3
    overflowHidden
    widthPct100
