module Component.Common.Separator.Style.Wing.End
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (backgroundColor)
import CSS as CSS
import Component.Common.Separator.Style.Util (grey)
import Util.Style (borderRadius1, heightRem, widthRem, (.?))

classId :: String
classId = "It2EVhda7"

style :: CSS.CSS
style = do
  classId .? do
    backgroundColor grey
    widthRem 1.0
    heightRem 1.0
    borderRadius1 5.0