module App.Component.Router.Menu.Style.Item.Children
  ( classId
  , style
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu (backgroundBlackAlpha)
import CSS (backgroundColor, rgba)
import CSS as CSS
import Util.Style (displayNone, flexWrap, reflectHashModuleName, topLeftToTopRight, widthPct100, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    topLeftToTopRight
    displayNone
    flexWrap
    widthPct100