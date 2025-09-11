module Component.Menu.Style.Item.Children
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (absolute, backgroundColor, display, displayNone, flexWrap, position, rem, rgba, top, transform, wrap)
import CSS as CSS
import CSS.Transform (translateX)
import Component.Menu.Style.Menu (backgroundBlackAlpha)
import Utils.Style ((<?))

classId :: String
classId = "YLBJc5NfZ"

style :: CSS.CSS
style = do
  classId <? do
    transform $ translateX (CSS.pct 100.0)
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    position absolute
    top (rem 0.0)
    display displayNone
    flexWrap wrap