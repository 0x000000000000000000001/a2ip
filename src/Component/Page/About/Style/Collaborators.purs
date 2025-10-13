module Component.Page.About.Style.Collaborators
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignContent, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, flexWrap, padding4, widthPct100, (.?))

classId :: String
classId = "Myat3GaT5"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContent center
    alignContent center
    flexWrap
    padding4 1.0 1.3 3.0 1.3
    widthPct100