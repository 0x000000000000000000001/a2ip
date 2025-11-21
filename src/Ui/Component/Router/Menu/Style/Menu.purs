module Ui.Component.Router.Menu.Style.Menu
  ( backgroundBlackAlpha
  , class'
  , foldWidth
  , menu
  , menu_
  , staticClass
  , style
  , unfoldWidth
  , zIndex
  )
  where

import Proem hiding (top)

import Ui.Component.Router.Menu.Type (State)
import CSS (alignItems, backgroundColor, borderRight, column, flexDirection, flexStart, height, hover, rem, rgba, solid, vh)
import CSS as CSS
import DOM.HTML.Indexed (HTMLnav)
import Halogen.HTML (HTML, Node, nav)
import Util.Style.Style (borderWidth1, classes, displayFlex, inferClass, left0, positionFixed, reflectStaticClass, top0, widthRem, (.&), (.?), (:?))

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

backgroundBlackAlpha ∷ Number
backgroundBlackAlpha = 0.85

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

zIndex :: Int
zIndex = 1000

style :: State -> CSS.CSS
style { id, unfold } = do
  staticClass .? do
    positionFixed
    top0
    left0
    height (vh 100.0)
    borderRight solid (rem 0.2) (rgba 0 0 0 0.4)
    CSS.zIndex zIndex
    displayFlex
    flexDirection column
    alignItems flexStart

  __hover :? do 
    borderWidth1 0.0

  class' id .? do
    widthRem $ unfold ? unfoldWidth ↔ foldWidth
    backgroundColor (rgba 0 0 0 $ unfold ? backgroundBlackAlpha ↔ 0.3)

  where 
  __hover = staticClass .& hover

menu :: ∀ w i. String -> Node HTMLnav w i
menu id props = nav ([ classes [staticClass, class' id] ] <> props)

menu_ :: ∀ w i. String -> Array (HTML w i) -> HTML w i
menu_ id = menu id []