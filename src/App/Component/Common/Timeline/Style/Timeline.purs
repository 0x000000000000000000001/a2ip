module App.Component.Common.Timeline.Style.Timeline
  ( staticClass
  , staticClassWhenLoading
  , style
  , timeline
  , timeline_
  )
  where

import Proem hiding (div, top)

import App.Component.Common.Timeline.Style.DownArrow as DownArrow
import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Number as Number
import App.Component.Common.Timeline.Style.Pin as Pin
import CSS (border, borderBox, borderRadius, boxSizing, height, inset, rem, solid, white, (|*))
import CSS as CSS
import Control.Monad.ST (while)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Style.Style (alignItemsCenter, backgroundWhite, borderRadius1, borderRadiusRem1, classes, displayFlex, fill, justifyContentCenter, loading, loadingGrey, margin1, margin2, noCss, overflowHidden, positionRelative, refineClass', reflectStaticClass, svg, transparent, (.&.), (.?), (:?), (:|*.))

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
    noCss

  ____line :? do
    loading

  ____pin :? do
    loading

  ____number :? do
    loading
    margin2 0.2 0.0
    borderRadiusRem1 0.3
    height (rem 0.9)

  ____downArrowSvg :? do
    fill loadingGrey

  where 
  __loading = staticClass .&. staticClassWhenLoading
  ____line = __loading :|*. Line.staticClass
  ____pin = __loading :|*. Pin.staticClass
  ____number = __loading :|*. Number.staticClass
  ____downArrowSvg = (__loading :|*. DownArrow.staticClass) |* svg

timeline :: ∀ w i. Boolean -> Node HTMLdiv w i
timeline loading props = div ([ classes [staticClass, loading ? staticClassWhenLoading ↔ ""] ] <> props)

timeline_ :: ∀ w i. Boolean -> Array (HTML w i) -> HTML w i
timeline_ loading = timeline loading []