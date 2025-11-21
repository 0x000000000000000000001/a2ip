module Ui.Component.Page.About.Style.Collaborators
  ( collaborators
  , collaborators_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (alignContent)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import CSS.Common (center)
import Util.Style.Style (class_, displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, padding4, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignContent center
    flexWrap
    padding4 1.0 1.3 3.0 1.3
    widthPct100

collaborators :: ∀ w i. Node HTMLdiv w i
collaborators props = div ([ class_ staticClass ] <> props)

collaborators_ :: ∀ w i. Array (HTML w i) -> HTML w i
collaborators_ = collaborators []