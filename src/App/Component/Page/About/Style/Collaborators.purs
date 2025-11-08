module App.Component.Page.About.Style.Collaborators
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (alignContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style.Style (displayFlex, flexWrap, reflectStatelessClass, justifyContentCenter, padding4, widthPct100, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignContent center
    flexWrap
    padding4 1.0 1.3 3.0 1.3
    widthPct100