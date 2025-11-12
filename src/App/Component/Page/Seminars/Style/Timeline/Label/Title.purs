module App.Component.Page.Seminars.Style.Timeline.Label.Title
  ( staticClass
  , style
  ) where

import Proem hiding (div, top)

import CSS (alignItems, flexStart)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, displayFlex, justifyContentCenter, minWidthRem, reflectStaticClass, (.?))

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