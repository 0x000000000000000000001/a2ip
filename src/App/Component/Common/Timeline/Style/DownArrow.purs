module App.Component.Common.Timeline.Style.DownArrow
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS as CSS
import Util.Style (alignItemsCenter, centerToBottomCenter, centerToCenter, displayFlex, fill, heightRem, justifyContentCenter, svg, widthRem, (.?), (.|*), (:?))

classId :: String
classId = "Gnkn8ajS5"

size :: Number
size = 3.0

style :: CSS.CSS
style = do
  classId .? do
    centerToBottomCenter
    displayFlex
    justifyContentCenter
    alignItemsCenter

  __svg :? do 
    centerToCenter
    widthRem size
    heightRem size
    fill grey

  where 
  __svg = classId .|* svg