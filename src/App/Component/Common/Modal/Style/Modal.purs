module App.Component.Common.Modal.Style.Modal
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (alignItemsCenter, displayFlex, justifyContentCenter, left0, minHeightPct, positionFixed, top0, widthPct100, (.?))

classId :: String
classId = "BVUZF1mw8"

style :: CSS.CSS
style = do
  classId .? do
    positionFixed
    top0
    left0
    displayFlex
    justifyContentCenter
    alignItemsCenter
    widthPct100
    minHeightPct 100.0