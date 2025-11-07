module App.Component.Router.Menu.Style.Item.Label
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import App.Component.Router.Menu.Type (State)
import CSS (opacity, visibility)
import CSS as CSS
import CSS.Common (hidden, visible)
import Util.Style.Style (flexGrow1, reflectHashModuleName, marginLeft, overflowHidden, widthRem, (.?))

classId :: String 
classId = reflectHashModuleName ι

style :: State -> CSS.CSS
style s = do
  classId .? do
    visibility (s.unfold ? visible ↔ hidden)
    opacity (s.unfold ? 1.0 ↔ 0.0)
    flexGrow1
    marginLeft 1.4
    widthRem 10.0
    overflowHidden