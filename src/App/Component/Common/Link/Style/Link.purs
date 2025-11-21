module App.Component.Common.Link.Style.Link
  ( class'
  , link
  , link_
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Link.Type (State)
import CSS (display, noneTextDecoration, textDecoration)
import CSS as CSS
import DOM.HTML.Indexed (HTMLa)
import Halogen.HTML (HTML, Node, a)
import Util.Style.Style (classes, cursorPointer, inferClass, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style { id, input: { display: display_ } } = do
  staticClass .? do 
    textDecoration noneTextDecoration
    cursorPointer

  class' id .? do
    display display_

link :: ∀ w i. String -> Array String -> Node HTMLa w i
link id classes' props = a ([ classes $ [staticClass, class' id] <> classes' ] <> props)

link_ :: ∀ w i. String -> Array String -> Array (HTML w i) -> HTML w i
link_ id classes' = link id classes' []