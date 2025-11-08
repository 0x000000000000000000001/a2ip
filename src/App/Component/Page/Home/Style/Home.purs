module App.Component.Page.Home.Style.Home
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (displayFlex, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    widthPct100