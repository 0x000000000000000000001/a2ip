module App.Component.Page.Seminars.Style.Timeline
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, reflectStaticClass, justifyContentCenter, widthRem, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    widthRem 10.0
    displayFlex
    justifyContentCenter
    alignItemsCenter