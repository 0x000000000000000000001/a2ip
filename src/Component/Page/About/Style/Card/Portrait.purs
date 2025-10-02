module Component.Page.About.Style.Card.Portrait
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (border, rem, solid)
import CSS as CSS
import Util.Style (borderRadius1, heightRem, marginTop, raw, red, widthRem, (.?))

classId :: String
classId = "yg13inAyQ"
 
width :: Number
width = 12.0

style :: CSS.CSS
style = do
  classId .? do
    widthRem width
    heightRem width
    raw "object-fit" "cover"
    border solid (rem 0.3) red
    borderRadius1 40.0
    marginTop 0.4