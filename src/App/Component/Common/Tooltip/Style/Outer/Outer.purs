module App.Component.Common.Tooltip.Style.Outer.Outer
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (centerLeftToCenterRight, reflectStatelessClass, widthPct100, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    widthPct100
    centerLeftToCenterRight
