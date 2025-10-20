module Component.Common.Timeline.Style.Date
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (cursorPointer, displayFlex, padding1, positionRelative, (.?))

classId :: String
classId = "JFD1v5Z7l"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContent center
    alignItems center
    padding1 2.0
    cursorPointer