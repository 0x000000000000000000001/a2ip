module App.Component.Common.Timeline.Style.Timeline
  ( staticClass
  , staticClassWhenLoading
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
import Util.Style.Style (alignItemsCenter, displayFlex, fill, justifyContentCenter, loading, loadingGrey, nothing, positionRelative, refineClass', reflectStaticClass, svg, (.&.), (.?), (:?), (:|*.))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenLoading :: String
staticClassWhenLoading = refineClass' staticClass loading_

style :: CSS.CSS
style = do
  staticClass .? do
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
  __loading = staticClass .&. staticClassWhenLoading
  ____line = __loading :|*. Line.staticClass
  ____pin = __loading :|*. Pin.staticClass
  ____number = __loading :|*. Number.staticClass
  ____downArrowSvg = (__loading :|*. DownArrow.staticClass) |* svg