module App.Component.Common.Carrousel.Style.Control.Control
  ( statelessClass
  , statelessClassWhenNext
  , statelessClassWhenPrev
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Carrousel.Style.Control.Icon as Icon
import CSS (backgroundColor, color, hover, rgba, white)
import CSS as CSS
import Color (darken)
import Util.Proxy.Dictionary.Next (next_)
import Util.Proxy.Dictionary.Prev (prev_)
import Util.Style.Style (alignItemsCenter, borderRadiusPct50, centerToCenterLeft, centerToCenterRight, cursorPointer, displayFlex, fontSizePct, fontWeightBold, heightRem, justifyContentCenter, leftRem, refineClass', reflectStatelessClass, rightRem, userSelectNone, widthRem, (.&:), (.?), (.|*.), (:?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

statelessClassWhenPrev :: String
statelessClassWhenPrev = refineClass' statelessClass prev_

statelessClassWhenNext :: String
statelessClassWhenNext = refineClass' statelessClass next_

style :: CSS.CSS
style = do
  statelessClass .? do
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

  statelessClassWhenPrev .? do 
    centerToCenterLeft

  a___icon :? do
    leftRem 1.0

  statelessClassWhenNext .? do
    centerToCenterRight

  b___icon :? do
    rightRem 1.0
  
  where 
  __hover = statelessClass .&: hover
  a___icon = statelessClassWhenPrev .|*. Icon.statelessClass
  b___icon = statelessClassWhenNext .|*. Icon.statelessClass