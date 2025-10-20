module Component.Common.Timeline.Style.Pin
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (backgroundColorRed, heightRem, widthRem, (.?))

classId :: String
classId = "a7j0ggkGu"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 3.0
    heightRem 3.0
    backgroundColorRed