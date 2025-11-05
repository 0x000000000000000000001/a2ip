module App.Component.Page.About.Style.About
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (displayFlex, flexWrap, reflectHashModuleName, justifyContentCenter, widthPct100, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    flexWrap
    widthPct100