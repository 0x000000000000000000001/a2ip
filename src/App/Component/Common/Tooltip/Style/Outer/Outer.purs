module App.Component.Common.Tooltip.Style.Outer.Outer
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (zIndex)
import CSS as CSS
import Util.Style.Style (centerLeftToCenterRight, positionRelative, reflectStaticClass, (.?))

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
