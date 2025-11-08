module App.Component.Router.Menu.Style.Item.Children
  ( statelessClass
  , style
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu (backgroundBlackAlpha)
import CSS (backgroundColor, rgba)
import CSS as CSS
import Util.Style.Style (displayNone, flexWrap, reflectStatelessClass, topLeftToTopRight, widthPct100, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    topLeftToTopRight
    displayNone
    flexWrap
    widthPct100