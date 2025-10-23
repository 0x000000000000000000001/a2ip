module App.Component.Page.Home.Style.Members
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignContent, flexStart)
import CSS as CSS
import Util.Style (displayFlex, flexWrap, justifyContentCenter, padding1, widthPct100, (.?))

classId :: String
classId = "lXmf1Jny2"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignContent flexStart
    flexWrap
    padding1 1.3
    widthPct100