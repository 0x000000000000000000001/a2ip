module App.Component.Common.Tooltip.Style.Outer.Outer
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (centerLeftToCenterRight, reflectHashModuleName, widthPct100, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    widthPct100
    centerLeftToCenterRight
