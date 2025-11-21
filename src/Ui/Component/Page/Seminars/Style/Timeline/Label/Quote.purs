module Ui.Component.Page.Seminars.Style.Timeline.Label.Quote
  ( quote
  , quote_
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, fontSizePct, positionRelative, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    fontSizePct 240.0 
    positionRelative

quote :: ∀ w i. Node HTMLdiv w i
quote props = div ([ class_ staticClass ] <> props)

quote_ :: ∀ w i. Array (HTML w i) -> HTML w i
quote_ = quote []