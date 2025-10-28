module App.Component.Common.Carrousel.Style.Counter
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (color, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style (borderRadiusRem4, bottomCenterToBottomCenter, displayFlex, justifyContentCenter, padding2, (.?))

classId :: String
classId = "ao2EMCBH7"

style :: CSS.CSS
style = do
  classId .? do
    bottomCenterToBottomCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.6 0.6 0.0 0.0
    color white
    padding2 0.3 0.5