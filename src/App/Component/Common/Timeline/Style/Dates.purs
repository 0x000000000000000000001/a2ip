module App.Component.Common.Timeline.Style.Dates
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (column, flexDirection)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, reflectStatelessClass, justifyContentCenter, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column