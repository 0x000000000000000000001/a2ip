module App.Component.Page.About.Style.Card.Names
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (colorRed, fontSizePct, fontWeightBold, reflectStaticClass, raw, widthPct, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    fontWeightBold
    fontSizePct 140.0
    colorRed
    widthPct 80.0
    raw "transition" "background-color 0s; color 0s"