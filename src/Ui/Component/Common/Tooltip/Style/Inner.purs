module Ui.Component.Common.Tooltip.Style.Inner
  ( inner
  , inner_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, noCss, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    noCss

inner :: ∀ w i. Node HTMLdiv w i
inner props = div ([ class_ staticClass ] <> props)

inner_ :: ∀ w i. Array (HTML w i) -> HTML w i
inner_ = inner []