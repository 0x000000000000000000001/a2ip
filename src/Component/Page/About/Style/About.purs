module Component.Page.About.Style.About
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (alignContent, flexStart, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Utils.Style (displayFlex, flexWrap, padding1, (.?))

classId :: String
classId = "mH916ksxM"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContent center
    alignContent flexStart
    flexWrap
    padding1 1.3