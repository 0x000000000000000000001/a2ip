module Component.Router.Menu.Style.Item.Label
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (flexGrow, marginLeft, opacity, rem, visibility, width)
import CSS as CSS
import CSS.Common (hidden, visible)
import CSS.Overflow as Overflow
import CSS.Overflow (overflow)
import Component.Router.Menu.Type (State)
import Utils.Style ((<?))

classId :: String
classId = "uLX54Ih61"

style :: State -> CSS.CSS
style s = do
  classId <? do
    visibility if s.isUnfold then visible else hidden
    opacity (if s.isUnfold then 1.0 else 0.0)
    flexGrow 1.0
    marginLeft (rem 1.4)
    width (rem 10.0)
    overflow Overflow.hidden