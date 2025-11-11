module App.Component.Common.Timeline.Style.Item
  ( staticClass
  , staticClassWhenSelected
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Date as Date
import App.Component.Common.Timeline.Style.Pin as Pin
import CSS (outline, rem, solid, transform)
import CSS as CSS
import Color (lighten)
import Util.Proxy.Dictionary.Selected (selected_)
import Util.Style.Style (alignItemsCenter, backgroundColorRed, backgroundColorWhite, borderRadiusPct50, centerRightToCenterWithRemDelta, colorRed, cursorPointer, displayFlex, fontSizePct, fontWeightBold, justifyContentCenter, padding1, positionRelative, red, refineClass', reflectStaticClass, (.&.), (.?), (.|*.), (:?), (:|*.))

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

  __date :? do
    backgroundColorWhite

  __selected :? do 
    outline solid (rem 0.2) $ lighten 0.1 red
    borderRadiusPct50
  
  ____date :? do
    colorRed
    fontWeightBold
    fontSizePct $ Date.fontSizePct + 10.0
    centerRightToCenterWithRemDelta (-2.0) 0.0

  ____pin :? do
    backgroundColorRed

  where 
  __date = staticClass .|*. Date.staticClass
  __selected = staticClass .&. staticClassWhenSelected
  ____date = __selected :|*. Date.staticClass
  ____pin = __selected :|*. Pin.staticClass