module Component.Page.Seminars.Style.DateContent
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (height, vh)
import CSS as CSS
import Util.Style (flexGrow1, positionSticky, top0, widthRem, (.?))

classId :: String
classId = "pj4FI9hBM"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 1.0
    flexGrow1
    height $ vh $ 100.0
    positionSticky
    top0