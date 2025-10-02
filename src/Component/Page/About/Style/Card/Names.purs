module Component.Page.About.Style.Card.Names
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS as CSS
import Util.Style (bold, colorRed, fontSizePct, raw, widthPct, (.?))

classId :: String
classId = "eq6HaLP07"

style :: CSS.CSS
style = do
  classId .? do
    bold
    fontSizePct 140.0
    colorRed
    widthPct 80.0
    raw "transition" "background-color 0s; color 0s"