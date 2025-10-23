module App.Component.Common.Timeline.Style.Dates
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (column, flexDirection)
import CSS as CSS
import Util.Style (alignItemsCenter, displayFlex, justifyContentCenter, (.?))

classId :: String
classId = "pqjXo2e0J"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column