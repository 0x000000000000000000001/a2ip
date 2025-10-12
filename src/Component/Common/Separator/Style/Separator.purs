module Component.Common.Separator.Style.Separator
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, padding4, widthPct100, (.?))

classId :: String
classId = "keWMC9TZj"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    alignItems center
    widthPct100
    padding4 1.6 0.8 0.6 0.8