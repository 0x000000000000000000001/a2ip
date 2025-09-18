module Component.Page.About.Style.Card.Portrait
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (border, borderRadius, height, rem, solid, marginTop)
import CSS as CSS
import Utils.Style (ourRed, raw, (<?))

classId :: String
classId = "yg13inAyQ"

width :: Number
width = 12.0

style :: CSS.CSS
style = do
  classId <? do
    CSS.width (rem width)
    height (rem width)
    raw "object-fit" "cover"
    border solid (rem 0.3) ourRed
    borderRadius (rem 0.0) (rem 40.0) (rem 40.0) (rem 40.0)
    marginTop (rem 0.3)