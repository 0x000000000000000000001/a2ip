module App.Component.Common.Input.Style.Label
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (cursor, pct, rem, transform, translate)
import CSS as CSS
import CSS.Cursor (text)
import Util.Style.Style (reflectHashModuleName, left0, positionAbsolute, topPct50, userSelectNone, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    topPct50
    left0
    transform $ translate (rem 0.6) (pct $ -50.0)
    cursor text
    userSelectNone
