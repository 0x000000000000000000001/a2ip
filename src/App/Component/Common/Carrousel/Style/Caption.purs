module App.Component.Common.Carrousel.Style.Caption
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (color, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style (borderRadiusRem4, displayFlex, reflectHashModuleName, justifyContentCenter, padding2, topCenterToTopCenter, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    topCenterToTopCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.0 0.0 0.6 0.6
    color white
    padding2 0.3 0.5