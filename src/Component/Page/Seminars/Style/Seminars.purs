module Component.Page.Seminars.Style.Seminars
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems, flexStart, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, widthPct100, (.?))

classId :: String
classId = "BgFNE5Wdc"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContent center
    alignItems flexStart
    widthPct100