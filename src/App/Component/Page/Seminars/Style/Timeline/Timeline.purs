module App.Component.Page.Seminars.Style.Timeline.Timeline
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, reflectStaticClass, justifyContentCenter, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    widthRem 10.0
    displayFlex
    justifyContentCenter
    alignItemsCenter

timeline :: ∀ w i. Node HTMLdiv w i
timeline props = div ([ class_ staticClass ] <> props)

timeline_ :: ∀ w i. Array (HTML w i) -> HTML w i
timeline_ = timeline []