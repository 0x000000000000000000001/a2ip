module App.Component.Page.Home.Style.Home
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (displayFlex, justifyContentCenter, widthPct100, (.?))

classId :: String
classId = "oR259S8lb"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    widthPct100