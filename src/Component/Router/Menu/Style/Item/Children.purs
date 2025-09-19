module Component.Router.Menu.Style.Item.Children
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (backgroundColor, pct, rgba, transform)
import CSS as CSS
import CSS.Transform (translateX)
import Component.Router.Menu.Style.Menu (backgroundBlackAlpha)
import Utils.Style (displayNone, flexWrap, positionAbsolute, top0, (.?))

classId :: String
classId = "YLBJc5NfZ"

style :: CSS.CSS
style = do
  classId .? do
    transform $ translateX (pct 100.0)
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    positionAbsolute
    top0
    displayNone
    flexWrap