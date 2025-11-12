module App.Component.Page.Seminars.Style.Timeline.Label.Title
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, justifyContentCenter, minWidthRem, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    minWidthRem 14.7
    displayFlex
    justifyContentCenter
    alignItems flexStart

title :: ∀ w i. Node HTMLdiv w i
title props = div ([ class_ staticClass ] <> props)

title_ :: ∀ w i. Array (HTML w i) -> HTML w i
title_ = title []