module App.Component.Common.Carrousel.Style.Caption
  ( statelessClass
  , style
  ) where

import Proem hiding (top)

import CSS (color, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style.Style (borderRadiusRem4, displayFlex, reflectStatelessClass, justifyContentCenter, padding2, topCenterToTopCenter, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    topCenterToTopCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.0 0.0 0.6 0.6
    color white
    padding2 0.3 0.5