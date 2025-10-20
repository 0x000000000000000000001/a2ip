module Component.Common.Timeline.Style.Number
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (fontSizePct, (.?))

classId :: String
classId = "tMm7IlU2V"

style :: CSS.CSS
style = do
  classId .? do
    fontSizePct 120.0