module App.Component.Router.Menu.Style.Item.Children
  ( staticClass
  , style
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu (backgroundBlackAlpha)
import CSS (backgroundColor, rgba)
import CSS as CSS
import Util.Style.Style (displayNone, flexWrap, reflectStaticClass, topLeftToTopRight, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    topLeftToTopRight
    displayNone
    flexWrap
    widthPct100