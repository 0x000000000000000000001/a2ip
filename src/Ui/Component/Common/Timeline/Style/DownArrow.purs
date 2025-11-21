module App.Component.Common.Timeline.Style.DownArrow
  ( downArrow
  , downArrow_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, IProp, Node, div)
import Html.Renderer.Halogen (render)
import Util.Style.Style (class_, alignItemsCenter, centerToBottomCenter, centerToCenter, displayFlex, fill, reflectStaticClass, heightRem, justifyContentCenter, svg, widthRem, (.?), (.|*), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

size :: Number
size = 3.0

style :: CSS.CSS
style = do
  staticClass .? do
    centerToBottomCenter
    displayFlex
    justifyContentCenter
    alignItemsCenter

  __svg :? do 
    centerToCenter
    widthRem size
    heightRem size
    fill grey

  where 
  __svg = staticClass .|* svg

downArrow :: ∀ w i. Array (IProp HTMLdiv i) -> String -> HTML w i
downArrow props = render ([ class_ staticClass ] <> props)

downArrow_ :: ∀ w i. String -> HTML w i
downArrow_ svgXml = downArrow [] svgXml