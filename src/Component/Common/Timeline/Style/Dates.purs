module Component.Common.Timeline.Style.Dates
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
classId = "pqjXo2e0J"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContent center
    alignItems center
    flexDirection column