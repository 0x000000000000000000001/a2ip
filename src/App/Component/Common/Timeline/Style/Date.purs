module App.Component.Common.Timeline.Style.Date
  ( classId
  , classIdWhenSelected
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Numbers as Numbers
import App.Component.Common.Timeline.Style.Pin as Pin
import CSS (outline, rem, solid, transform)
import CSS as CSS
import Color (lighten)
import Util.Proxy.Dictionary.Selected (selected_)
import Util.Style (alignItemsCenter, backgroundColorRed, backgroundColorWhite, borderRadiusPct1, colorRed, cursorPointer, displayFlex, fontSizePct, fontWeightBold, justifyContentCenter, padding1, positionRelative, red, refine, reflectHashModuleName, (.&.), (.?), (.|*.), (:?), (:|*.))

classId :: String
classId = reflectHashModuleName ι

classIdWhenSelected :: String 
classIdWhenSelected = refine classId selected_

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    alignItemsCenter
    padding1 2.0
    cursorPointer

  __numbers :? do
    backgroundColorWhite

  __selected :? do 
    outline solid (rem 0.2) $ lighten 0.1 red
    borderRadiusPct1 50.0
  
  ____numbers :? do
    colorRed
    fontWeightBold
    fontSizePct $ Numbers.fontSizePct + 10.0
    transform $ Numbers.translate $ Numbers.translateXDelta - 1.0
  
  ____pin :? do 
    backgroundColorRed

  where 
  __numbers = classId .|*. Numbers.classId
  __selected = classId .&. classIdWhenSelected
  ____numbers = __selected :|*. Numbers.classId
  ____pin = __selected :|*. Pin.classId