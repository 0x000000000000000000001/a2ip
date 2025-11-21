module App.Component.Common.Carrousel.Style.Control.Icon
  ( icon
  , icon_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, positionRelative, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative

icon :: ∀ w i. Node HTMLdiv w i
icon props = div ([ class_ staticClass ] <> props)

icon_ :: ∀ w i. Array (HTML w i) -> HTML w i
icon_ = icon []