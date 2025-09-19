module Component.Page.About.Style.Card.Names
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (bold, color, fontSize, fontWeight, pct, width)
import CSS as CSS
import Utils.Style (fontRed, raw, (.?))

classId :: String
classId = "eq6HaLP07"

style :: CSS.CSS
style = do
  classId .? do
    fontWeight bold
    fontSize (pct 140.0)
    color fontRed
    width (pct 80.0)
    raw "transition" "background-color 0s; color 0s"