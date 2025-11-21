module Ui.Component.Common.Timeline.Style.Number
  ( number
  , number_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, reflectStaticClass, noCss, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    noCss
  
number :: ∀ w i. Node HTMLdiv w i
number props = div ([ class_ staticClass ] <> props)

number_ :: ∀ w i. Array (HTML w i) -> HTML w i
number_ = number []