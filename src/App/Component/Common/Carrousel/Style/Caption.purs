module App.Component.Common.Carrousel.Style.Caption
  ( caption
  , caption_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS (color, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (borderRadiusRem4, class_, displayFlex, justifyContentCenter, padding2, reflectStaticClass, topCenterToTopCenter, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    topCenterToTopCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.0 0.0 0.6 0.6
    color white
    padding2 0.3 0.5

caption :: ∀ w i. Node HTMLdiv w i
caption props = div ([ class_ staticClass ] <> props)

caption_ :: ∀ w i. Array (HTML w i) -> HTML w i
caption_ = caption []