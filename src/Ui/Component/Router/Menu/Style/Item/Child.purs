module Ui.Component.Router.Menu.Style.Item.Child
  ( child
  , child_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS (hover)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (backgroundColorRed, class_, padding1, raw, reflectStaticClass, widthPct100, (.&), (.?), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    padding1 0.8
    widthPct100
    raw "transition" "background-color 0s"

  __hover :? do
    backgroundColorRed

  where 
  __hover = staticClass .& hover 

child :: ∀ w i. Node HTMLdiv w i
child props = div ([ class_ staticClass ] <> props)

child_ :: ∀ w i. Array (HTML w i) -> HTML w i
child_ = child []