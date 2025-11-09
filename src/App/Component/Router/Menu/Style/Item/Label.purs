module App.Component.Router.Menu.Style.Item.Label
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Type (State)
import CSS (opacity, visibility)
import CSS as CSS
import CSS.Common (hidden, visible)
import Util.Style.Style (flexGrow1, inferClass, marginLeft, overflowHidden, reflectStaticClass, widthRem, (.?))

staticClass :: String 
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style { id, unfold } = do
  staticClass .? do
    flexGrow1
    marginLeft 1.4
    widthRem 10.0
    overflowHidden
  
  class' id .? do 
    visibility (unfold ? visible ↔ hidden)
    opacity (unfold ? 1.0 ↔ 0.0)