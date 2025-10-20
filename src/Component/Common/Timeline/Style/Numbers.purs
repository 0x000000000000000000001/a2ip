module Component.Common.Timeline.Style.Numbers
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, column, flexDirection, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, (.?))

classId :: String
classId = "ck6YcOjPV"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContent center
    alignItems center
    flexDirection column