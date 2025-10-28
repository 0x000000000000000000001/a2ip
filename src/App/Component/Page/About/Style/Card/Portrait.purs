module App.Component.Page.About.Style.Card.Portrait
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (border, rem, solid)
import CSS as CSS
import App.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import Util.Style (borderRadiusRem1, fill, heightRem, marginTop, raw, red, textRed, widthRem, (.?), (.|*.), (:?))

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
    borderRadiusRem1 40.0
    marginTop 0.4

  __questionMark :? do
    fill $ textRed

  where 

  __questionMark = classId .|*. QuestionMark.classId