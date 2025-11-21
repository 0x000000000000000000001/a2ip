module Ui.Component.Common.Carrousel.Style.Control.Control
  ( control
  , control_
  , staticClass
  , staticClassWhenNext
  , staticClassWhenPrev
  , style
  )
  where

import Proem hiding (top, div)

import Ui.Component.Common.Carrousel.Style.Control.Icon as Icon
import CSS (backgroundColor, color, hover, rgba, white)
import CSS as CSS
import Color (darken)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Proxy.Dictionary.Next (next_)
import Util.Proxy.Dictionary.Prev (prev_)
import Util.Style.Style (alignItemsCenter, borderRadiusPct50, centerToCenterLeft, centerToCenterRight, classes, cursorPointer, displayFlex, fontSizePct, fontWeightBold, heightRem, justifyContentCenter, leftRem, refineClass', reflectStaticClass, rightRem, userSelectNone, widthRem, (.&:), (.?), (.|*.), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenPrev :: String
staticClassWhenPrev = refineClass' staticClass prev_

staticClassWhenNext :: String
staticClassWhenNext = refineClass' staticClass next_

style :: CSS.CSS
style = do
  staticClass .? do
    cursorPointer
    userSelectNone
    backgroundColor $ rgba 0 0 0 0.75
    heightRem 5.0
    widthRem 5.0
    borderRadiusPct50
    displayFlex
    justifyContentCenter
    alignItemsCenter
    color $ darken 0.1 white
    fontWeightBold
    fontSizePct 130.0

  __hover :? do 
    backgroundColor $ rgba 0 0 0 0.93
    heightRem 6.3
    widthRem 6.3

  staticClassWhenPrev .? do 
    centerToCenterLeft

  a___icon :? do
    leftRem 1.0

  staticClassWhenNext .? do
    centerToCenterRight

  b___icon :? do
    rightRem 1.0
  
  where 
  __hover = staticClass .&: hover
  a___icon = staticClassWhenPrev .|*. Icon.staticClass
  b___icon = staticClassWhenNext .|*. Icon.staticClass

control :: ∀ w i. Boolean -> Node HTMLdiv w i
control prev props = div ([ classes [ staticClass, prev ? staticClassWhenPrev ↔ staticClassWhenNext ] ] <> props)

control_ :: ∀ w i. Boolean -> Array (HTML w i) -> HTML w i
control_ prev = control prev []