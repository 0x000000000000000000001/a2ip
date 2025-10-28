module App.Component.Common.Carrousel.Style.Carrousel
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (rgba)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style (borderRadiusRem1, displayFlex, heightRem, justifyContentCenter, overflowHidden, positionRelative, widthRem, (.?))

classId :: String
classId = "bg2Md6TUT"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    heightRem 30.0
    widthRem 55.0
    backgroundColor $ rgba 0 0 0 0.6
    borderRadiusRem1 0.6
    overflowHidden
