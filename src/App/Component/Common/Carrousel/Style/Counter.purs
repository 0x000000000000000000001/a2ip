module App.Component.Common.Carrousel.Style.Counter
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (color, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style.Style (borderRadiusRem4, bottomCenterToBottomCenter, displayFlex, reflectStaticClass, justifyContentCenter, padding2, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    bottomCenterToBottomCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.6 0.6 0.0 0.0
    color white
    padding2 0.3 0.5