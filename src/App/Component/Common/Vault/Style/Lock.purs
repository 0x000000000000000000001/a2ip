module App.Component.Common.Vault.Style.Lock
  ( lock
  , lock_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (opacity, zIndex)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, IProp, Node, div)
import Html.Renderer.Halogen (render)
import Util.Style.Style (alignItemsCenter, borderRadiusPct50, class_, displayFlex, heightRem, justifyContentCenter, margin1, positionRelative, reflectStaticClass, svg, widthRem, (.?), (.|*:), (:?))

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

lock :: ∀ w i. Array (IProp HTMLdiv i) -> String -> HTML w i
lock props = render ([ class_ staticClass ] <> props)

lock_ :: ∀ w i. String -> HTML w i
lock_ svgXml = lock [] svgXml
