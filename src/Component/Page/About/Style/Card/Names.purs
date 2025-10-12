module Component.Page.About.Style.Card.Names
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (fontWeightBold, colorRed, fontSizePct, raw, widthPct, (.?))

classId :: String
classId = "eq6HaLP07"

style :: CSS.CSS
style = do
  classId .? do
    fontWeightBold
    fontSizePct 140.0
    colorRed
    widthPct 80.0
    raw "transition" "background-color 0s; color 0s"