module Ui.Component.Page.Seminars.Style.Seminars
  ( seminars
  , seminars_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (alignItems, flexStart)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, displayFlex, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItems flexStart
    widthPct100

seminars :: ∀ w i. Node HTMLdiv w i
seminars props = div ([ class_ staticClass ] <> props)

seminars_ :: ∀ w i. Array (HTML w i) -> HTML w i
seminars_ = seminars []