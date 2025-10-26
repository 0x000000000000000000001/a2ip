module App.Component.Common.Timeline.Style.Timeline
  ( classId
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Pin as Pin
import App.Component.Common.Timeline.Style.Number as Number
import CSS as CSS
import Util.Style (alignItemsCenter, displayFlex, justifyContentCenter, loading, nothing, positionRelative, (.&.), (.?), (:?), (:|*.))

classId :: String
classId = "GWrzwcv2h"

classIdWhenLoading :: String
classIdWhenLoading = "D1JvFEC00"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    alignItemsCenter

  __loading :? do 
    nothing

  ____line :? do
    loading

  ____pin :? do
    loading

  ____number :? do
    loading

  where 
  __loading = classId .&. classIdWhenLoading
  ____line = __loading :|*. Line.classId
  ____pin = __loading :|*. Pin.classId
  ____number = __loading :|*. Number.classId