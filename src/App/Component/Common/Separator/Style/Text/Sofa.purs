module App.Component.Common.Separator.Style.Text.Sofa
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import App.Component.Common.Separator.Style.Util (grey)
import Util.Style (fill, heightRem, leftPct50, onlyTranslatePct, positionAbsolute, top0, widthRem, (.?))

classId :: String
classId = "wQLJ9256h"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    top0
    leftPct50
    onlyTranslatePct (-50.0) (-75.0)
    fill grey
    widthRem 4.0
    heightRem 4.0