module App.Component.Common.Input.Style.Label
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (cursor, pct, rem, transform, translate)
import CSS as CSS
import CSS.Cursor (text)
import Util.Style (left0, positionAbsolute, topPct50, userSelectNone, (.?))

classId :: String
classId = "OmK5nX9TU"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    topPct50
    left0
    transform $ translate (rem 0.4) (pct $ -50.0)
    cursor text
    userSelectNone
