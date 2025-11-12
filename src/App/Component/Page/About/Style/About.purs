module App.Component.Page.About.Style.About
  ( staticClass
  , style
  ) where

import Proem hiding (div, top)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    flexWrap
    widthPct100

about :: ∀ w i. Node HTMLdiv w i
about props = div ([ class_ staticClass ] <> props)

about_ :: ∀ w i. Array (HTML w i) -> HTML w i
about_ = about []