module Ui.Component.Page.Seminars.Style.Timeline.Label.Person
  ( person
  , person_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS (flexEnd, justifyContent)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (alignItemsCenter, class_, displayFlex, padding4, reflectStaticClass, (.?))


staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    padding4 1.0 0.4 0.4 0.4
    displayFlex
    justifyContent flexEnd
    alignItemsCenter

person :: ∀ w i. Node HTMLdiv w i
person props = div ([ class_ staticClass ] <> props)

person_ :: ∀ w i. Array (HTML w i) -> HTML w i
person_ = person []