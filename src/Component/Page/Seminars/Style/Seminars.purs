module Component.Page.Seminars.Style.Seminars
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems, flexStart)
import CSS as CSS
import Util.Style (displayFlex, justifyContentCenter, widthPct100, (.?))

classId :: String
classId = "BgFNE5Wdc"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignItems flexStart
    widthPct100