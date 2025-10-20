module Component.Common.Timeline.Style.Date
  ( classId
  , classIdWhenSelected
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, color, justifyContent, outline, rem, solid, transform)
import CSS as CSS
import CSS.Common (center)
import Color (darken, lighten)
import Component.Common.Timeline.Style.Numbers as Numbers
import Component.Common.Timeline.Style.Pin as Pin
import Util.Style (backgroundColorRed, backgroundColorWhite, borderRadius1, cursorPointer, displayFlex, fontSizePct, fontWeightBold, padding1, positionRelative, red, (.&.), (.?), (:?), (:|*.))

classId :: String
classId = "JFD1v5Z7l"

classIdWhenSelected :: String 
classIdWhenSelected = "Tu2jY45nL"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContent center
    alignItems center
    padding1 2.0
    cursorPointer

  __selected :? do 
    outline solid (rem 0.2) $ lighten 0.1 red
    borderRadius1 40.0
  
  ____numbers :? do
    color $ darken 0.1 red
    fontWeightBold
    fontSizePct $ Numbers.fontSizePct + 10.0
    transform $ Numbers.translate $ Numbers.translateXDelta - 1.0
    backgroundColorWhite
  
  ____pin :? do 
    backgroundColorRed

  where 
  __selected = classId .&. classIdWhenSelected
  ____numbers = __selected :|*. Numbers.classId
  ____pin = __selected :|*. Pin.classId