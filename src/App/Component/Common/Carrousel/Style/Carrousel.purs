module App.Component.Common.Carrousel.Style.Carrousel
  ( statelessClass
  , style
  )
  where

import Proem hiding (top)

import CSS (rgba)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style (borderRadiusRem1, displayFlex, reflectHashModuleName, heightRem, justifyContentCenter, overflowHidden, positionRelative, widthRem, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

style :: CSS.CSS
style = do
  statelessClass .? do
    positionRelative
    displayFlex
    justifyContentCenter
    heightRem 30.0
    widthRem 55.0
    backgroundColor $ rgba 0 0 0 0.6
    borderRadiusRem1 0.6
    overflowHidden
