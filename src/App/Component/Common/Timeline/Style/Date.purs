module App.Component.Common.Timeline.Style.Date
  ( staticClass
  , staticClassWhenSelected
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
import Util.Style.Style (alignItemsCenter, backgroundColorRed, backgroundColorWhite, borderRadiusPct50, colorRed, cursorPointer, displayFlex, fontSizePct, fontWeightBold, justifyContentCenter, padding1, positionRelative, red, refineClass', reflectStaticClass, (.&.), (.?), (.|*.), (:?), (:|*.))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenSelected :: String 
staticClassWhenSelected = refineClass' staticClass selected_

style :: CSS.CSS
style = do
  staticClass .? do
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
    borderRadiusPct50
  
  ____numbers :? do
    colorRed
    fontWeightBold
    fontSizePct $ Numbers.fontSizePct + 10.0
    transform $ Numbers.translate $ Numbers.translateXDelta - 1.0
  
  ____pin :? do 
    backgroundColorRed

  where 
  __numbers = staticClass .|*. Numbers.staticClass
  __selected = staticClass .&. staticClassWhenSelected
  ____numbers = __selected :|*. Numbers.staticClass
  ____pin = __selected :|*. Pin.staticClass