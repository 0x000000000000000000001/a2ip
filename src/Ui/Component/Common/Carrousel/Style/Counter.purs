module Ui.Component.Common.Carrousel.Style.Counter
  ( counter
  , counter_
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
import Util.Style.Style (borderRadiusRem4, bottomCenterToBottomCenter, class_, displayFlex, justifyContentCenter, padding2, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    bottomCenterToBottomCenter
    displayFlex
    justifyContentCenter
    backgroundColor $ rgba 0 0 0 0.8
    borderRadiusRem4 0.6 0.6 0.0 0.0
    color white
    padding2 0.3 0.5

counter :: ∀ w i. Node HTMLdiv w i
counter props = div ([ class_ staticClass ] <> props)

counter_ :: ∀ w i. Array (HTML w i) -> HTML w i
counter_ = counter []