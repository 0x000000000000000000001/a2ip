module App.Component.Common.Vault.Style.Lock
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (opacity, zIndex)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, borderRadiusPct50, displayFlex, heightRem, justifyContentCenter, margin1, positionRelative, reflectStaticClass, svg, widthRem, (.?), (.|*:), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    margin1 1.2
    opacity 0.9
    positionRelative
    zIndex 5
    borderRadiusPct50
    displayFlex
    justifyContentCenter
    alignItemsCenter

  __svg :? do 
    widthRem 8.0
    heightRem 8.0

  where 
  __svg = staticClass .|*: svg

lock :: ∀ w i. Node HTMLdiv w i
lock props = div ([ class_ staticClass ] <> props)

lock_ :: ∀ w i. Array (HTML w i) -> HTML w i
lock_ = lock []
