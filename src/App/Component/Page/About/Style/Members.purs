module App.Component.Page.About.Style.Members
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (alignContent, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, padding1, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignContent flexStart
    flexWrap
    padding1 1.3
    widthPct100