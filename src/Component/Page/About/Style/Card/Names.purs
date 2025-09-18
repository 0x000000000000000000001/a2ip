module Component.Page.About.Style.Card.Names
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (border, color, padding, borderRadius, height, rem, solid, fontWeight, bold, fontSize, pct)
import CSS as CSS
import Utils.Style (ourFontRed, raw, (<?))

classId :: String
classId = "eq6HaLP07"

width :: Number
width = 12.0

style :: CSS.CSS
style = do
  classId <? do
    fontWeight bold
    fontSize (pct 120.0)
    color ourFontRed