module Component.Page.About.Style.Card.Names
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (bold, color, fontSize, fontWeight, pct)
import CSS as CSS
import Utils.Style (fontRed, raw, (<?))

classId :: String
classId = "eq6HaLP07"

style :: CSS.CSS
style = do
  classId <? do
    fontWeight bold
    fontSize (pct 120.0)
    color fontRed
    raw "transition" "background-color 0s"