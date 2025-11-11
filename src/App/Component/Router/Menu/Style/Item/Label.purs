module App.Component.Router.Menu.Style.Item.Label
  ( class'
  , label
  , label_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Type (State)
import CSS (opacity, visibility)
import CSS as CSS
import CSS.Common (hidden, visible)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (classes, flexGrow1, inferClass, marginLeft, overflowHidden, reflectStaticClass, widthRem, (.?))

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

label :: ∀ w i. String -> Node HTMLdiv w i
label id props = div ([ classes [staticClass, class' id] ] <> props)

label_ :: ∀ w i. String -> Array (HTML w i) -> HTML w i
label_ id = label id []