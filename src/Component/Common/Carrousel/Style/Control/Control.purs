module Component.Common.Carrousel.Style.Control.Control
  ( classId
  , classIdWhenNext
  , classIdWhenPrev
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, backgroundColor, color, justifyContent, left, pct, rem, rgba, right, top, transform, translate, white)
import CSS as CSS
import CSS.Common (center)
import Color (darken)
import Component.Common.Carrousel.Style.Control.Icon as Icon
import Util.Style (borderRadius1, cursorPointer, displayFlex, fontSizePct, fontWeightBold, heightRem, left0, leftRem, positionAbsolute, right0, rightRem, topPct50, userSelectNone, widthRem, (.&.), (.?), (:?), (:|*.))

classId :: String
classId = "MrL2fqlli"

classIdWhenPrev :: String
classIdWhenPrev = "RcTXs8T8D"

classIdWhenNext :: String
classIdWhenNext = "M6RWLsugg"

style :: CSS.CSS
style = do
  classId .? do
    positionAbsolute
    cursorPointer
    userSelectNone
    topPct50
    backgroundColor $ rgba 0 0 0 0.75
    heightRem 5.0
    widthRem 5.0
    borderRadius1 10.0
    displayFlex
    justifyContent center
    alignItems center
    color $ darken 0.1 white
    fontWeightBold
    fontSizePct 130.0

  __prev :? do 
    left0
    transform $ translate (pct $ -50.0) (pct $ -50.0)

  a___icon :? do
    leftRem 1.0

  __next :? do
    right0
    transform $ translate (pct 50.0) (pct $ -50.0)

  b___icon :? do
    rightRem 1.0
  
  where 
  __prev = classId .&. classIdWhenPrev
  a___icon = __prev :|*. Icon.classId
  __next = classId .&. classIdWhenNext
  b___icon = __next :|*. Icon.classId