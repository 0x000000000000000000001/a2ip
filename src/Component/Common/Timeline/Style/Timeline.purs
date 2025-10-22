module Component.Common.Timeline.Style.Timeline
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (alignItemsCenter, displayFlex, justifyContentCenter, positionRelative, (.?))

classId :: String
classId = "GWrzwcv2h"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    alignItemsCenter