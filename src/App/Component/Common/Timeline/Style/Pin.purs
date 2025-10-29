module App.Component.Common.Timeline.Style.Pin
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS (backgroundColor)
import CSS as CSS
import Util.Style (borderRadiusPct1, heightRem, widthRem, (.?))

classId :: String
classId = "a7j0ggkGu"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 1.4
    heightRem 1.4
    borderRadiusPct1 50.0
    backgroundColor grey