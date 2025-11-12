module App.Component.Common.Timeline.Style.Pin
  ( staticClass
  , style
  )
  where

import Proem hiding (div, top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS (backgroundColor)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, borderRadiusPct50, heightRem, reflectStaticClass, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    widthRem 1.4
    heightRem 1.4
    borderRadiusPct50
    backgroundColor grey

pin :: ∀ w i. Node HTMLdiv w i
pin props = div ([ class_ staticClass ] <> props)

pin_ :: ∀ w i. Array (HTML w i) -> HTML w i
pin_ = pin []