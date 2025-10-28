module App.Component.Common.Timeline.Style.Pin
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor)
import CSS as CSS
import App.Component.Common.Timeline.Style.Util (grey)
import Util.Style (borderRadiusRem1, heightRem, widthRem, (.?))

classId :: String
classId = "a7j0ggkGu"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 1.4
    heightRem 1.4
    borderRadiusRem1 3.0
    backgroundColor grey