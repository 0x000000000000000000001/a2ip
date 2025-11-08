module App.Component.Common.Carrousel.Style.Counter
  ( statelessClass
  , style
  ) where

import Proem hiding (top)

import CSS (color, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style.Style (borderRadiusRem4, bottomCenterToBottomCenter, displayFlex, reflectStatelessClass, justifyContentCenter, padding2, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    bottomCenterToBottomCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.6 0.6 0.0 0.0
    color white
    padding2 0.3 0.5