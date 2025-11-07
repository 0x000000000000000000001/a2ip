module App.Component.Common.Carrousel.Style.Control.Control
  ( classId
  , classIdWhenNext
  , classIdWhenPrev
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
import Util.Style (alignItemsCenter, borderRadiusPct50, centerToCenterLeft, centerToCenterRight, cursorPointer, displayFlex, fontSizePct, fontWeightBold, heightRem, justifyContentCenter, leftRem, refineClass, reflectHashModuleName, rightRem, userSelectNone, widthRem, (.&.), (.&:), (.?), (:?), (:|*.))

classId :: String
classId = reflectHashModuleName ι

classIdWhenPrev :: String
classIdWhenPrev = refineClass classId prev_

classIdWhenNext :: String
classIdWhenNext = refineClass classId next_

style :: CSS.CSS
style = do
  classId .? do
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

  __prev :? do 
    centerToCenterLeft

  a___icon :? do
    leftRem 1.0

  __next :? do
    centerToCenterRight

  b___icon :? do
    rightRem 1.0
  
  where 
  __hover = classId .&: hover
  __prev = classId .&. classIdWhenPrev
  a___icon = __prev :|*. Icon.classId
  __next = classId .&. classIdWhenNext
  b___icon = __next :|*. Icon.classId