module Component.Router.Menu.Style.Item.Label
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import CSS (opacity, visibility)
import CSS as CSS
import CSS.Common (hidden, visible)
import Component.Router.Menu.Type (State)
import Util.Style (marginLeft, flexGrow1, overflowHidden, widthRem, (.?))

classId :: String 
classId = "uLX54Ih61"

style :: State -> CSS.CSS
style s = do
  classId .? do
    visibility (s.isUnfold ? visible ↔ hidden)
    opacity (s.isUnfold ? 1.0 ↔ 0.0)
    flexGrow1
    marginLeft 1.4
    widthRem 10.0
    overflowHidden