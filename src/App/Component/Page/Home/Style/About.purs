module App.Component.Page.Home.Style.Home
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (displayFlex, flexWrap, justifyContentCenter, widthPct100, (.?))

classId :: String
classId = "mH916ksxM"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    flexWrap
    widthPct100