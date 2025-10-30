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
import Util.Style (alignItemsCenter, displayFlex, fill, justifyContentCenter, loading, loadingGrey, nothing, positionRelative, svg, (.&.), (.?), (:?), (:|*.))

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

  ____downArrowSvg :? do
    fill loadingGrey

  where 
  __loading = classId .&. classIdWhenLoading
  ____line = __loading :|*. Line.classId
  ____pin = __loading :|*. Pin.classId
  ____number = __loading :|*. Number.classId
  ____downArrowSvg = (__loading :|*. DownArrow.classId) |* svg