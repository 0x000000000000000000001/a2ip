module App.Component.Page.Home.Style.Home
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (displayFlex, reflectStatelessClass, justifyContentCenter, widthPct100, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    widthPct100