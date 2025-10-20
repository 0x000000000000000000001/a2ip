module Component.Page.Seminars.Style.Timeline
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, widthRem, (.?))

classId :: String
classId = "u8NVJpmCE"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 10.0
    displayFlex
    justifyContent center 
    alignItems center