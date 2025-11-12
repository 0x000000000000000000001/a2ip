module App.Component.Common.Tooltip.Style.Outer.Outer
  ( staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (zIndex)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, centerLeftToCenterRight, positionRelative, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    centerLeftToCenterRight
    zIndex 10

outer :: ∀ w i. Node HTMLdiv w i
outer props = div ([ class_ staticClass ] <> props)

outer_ :: ∀ w i. Array (HTML w i) -> HTML w i
outer_ = outer []
