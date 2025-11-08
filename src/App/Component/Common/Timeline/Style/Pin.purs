module App.Component.Common.Timeline.Style.Pin
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS (backgroundColor)
import CSS as CSS
import Util.Style.Style (borderRadiusPct50, heightRem, reflectStaticClass, widthRem, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    widthRem 1.4
    heightRem 1.4
    borderRadiusPct50
    backgroundColor grey