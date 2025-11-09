module App.Component.Page.About.Style.About
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    flexWrap
    widthPct100