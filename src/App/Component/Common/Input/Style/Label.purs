module App.Component.Common.Input.Style.Label
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (cursor, pct, rem, transform, translate)
import CSS as CSS
import CSS.Cursor (text)
import Util.Style.Style (reflectStaticClass, left0, positionAbsolute, topPct50, userSelectNone, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionAbsolute
    topPct50
    left0
    transform $ translate (rem 0.8) (pct $ -50.0)
    cursor text
    userSelectNone
