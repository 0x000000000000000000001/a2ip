module Component.Router.Menu.Style.Item.Children
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import CSS (backgroundColor, rgba)
import CSS as CSS
import Component.Router.Menu.Style.Menu (backgroundBlackAlpha)
import Util.Style (displayNone, flexWrap, topLeftToTopRight, widthPct100, (.?))

classId :: String
classId = "YLBJc5NfZ"

style :: CSS.CSS
style = do
  classId .? do
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    topLeftToTopRight
    displayNone
    flexWrap
    widthPct100