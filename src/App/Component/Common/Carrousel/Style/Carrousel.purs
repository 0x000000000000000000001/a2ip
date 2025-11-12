module App.Component.Common.Carrousel.Style.Carrousel
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (rgba)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style.Style (borderRadiusRem1, displayFlex, reflectStaticClass, heightRem, justifyContentCenter, overflowHidden, positionRelative, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    displayFlex
    justifyContentCenter
    heightRem 30.0
    widthRem 55.0
    backgroundColor $ rgba 0 0 0 0.6
    borderRadiusRem1 0.6
    overflowHidden

carrousel :: ∀ w i. Node HTMLdiv w i
carrousel = div ([ class_ staticClass ] <> props)

carrousel_ :: ∀ w i. Array (HTML w i) -> HTML w i
carrousel_ = carrousel []
