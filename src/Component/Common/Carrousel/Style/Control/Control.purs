module Component.Common.Carrousel.Style.Control.Control
  ( classId
  , classIdWhenNext
  , classIdWhenPrev
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, color, rgba, white)
import CSS as CSS
import Color (darken)
import Component.Common.Carrousel.Style.Control.Icon as Icon
import Util.Style (alignItemsCenter, borderRadius1, centerLeftToCenterLeft, centerRightToCenterRight, cursorPointer, displayFlex, fontSizePct, fontWeightBold, heightRem, justifyContentCenter, leftRem, rightRem, userSelectNone, widthRem, (.&.), (.?), (:?), (:|*.))

classId :: String
classId = "MrL2fqlli"

classIdWhenPrev :: String
classIdWhenPrev = "RcTXs8T8D"

classIdWhenNext :: String
classIdWhenNext = "M6RWLsugg"

style :: CSS.CSS
style = do
  classId .? do
    cursorPointer
    userSelectNone
    backgroundColor $ rgba 0 0 0 0.75
    heightRem 5.0
    widthRem 5.0
    borderRadius1 10.0
    displayFlex
    justifyContentCenter
    alignItemsCenter
    color $ darken 0.1 white
    fontWeightBold
    fontSizePct 130.0

  __prev :? do 
    centerLeftToCenterLeft

  a___icon :? do
    leftRem 1.0

  __next :? do
    centerRightToCenterRight

  b___icon :? do
    rightRem 1.0
  
  where 
  __prev = classId .&. classIdWhenPrev
  a___icon = __prev :|*. Icon.classId
  __next = classId .&. classIdWhenNext
  b___icon = __next :|*. Icon.classId