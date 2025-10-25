module App.Component.Page.Seminars.Style.Poster
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems, column, flexDirection)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, flexGrow1, justifyContentCenter, padding1, positionSticky, top0, widthRem, (.?))

classId :: String
classId = "Lc76GkHSV"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignItems center
    flexDirection column
    widthRem 1.0
    flexGrow1
    positionSticky
    top0
    padding1 2.0