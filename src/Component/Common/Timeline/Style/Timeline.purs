module Component.Common.Timeline.Style.Timeline
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, positionRelative, (.?))

classId :: String
classId = "GWrzwcv2h"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContent center
    alignItems center