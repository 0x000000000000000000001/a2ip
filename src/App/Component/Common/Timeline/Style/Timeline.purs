module App.Component.Common.Timeline.Style.Timeline
  ( classId
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.DownArrow as DownArrow
import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Number as Number
import App.Component.Common.Timeline.Style.Pin as Pin
import CSS ((|*))
import CSS as CSS
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Style.Style (alignItemsCenter, displayFlex, fill, justifyContentCenter, loading, loadingGrey, nothing, positionRelative, refineClass, reflectHashModuleName, svg, (.&.), (.?), (:?), (:|*.))

classId :: String
classId = reflectHashModuleName ι

classIdWhenLoading :: String
classIdWhenLoading = refineClass classId loading_

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

  ____downArrowSvg :? do
    fill loadingGrey

  where 
  __loading = classId .&. classIdWhenLoading
  ____line = __loading :|*. Line.classId
  ____pin = __loading :|*. Pin.classId
  ____number = __loading :|*. Number.classId
  ____downArrowSvg = (__loading :|*. DownArrow.classId) |* svg