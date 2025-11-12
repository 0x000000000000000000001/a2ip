module App.Component.Page.Home.Style.Home
  ( staticClass
  , style
  ) where

import Proem hiding (div, top)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, displayFlex, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    widthPct100

home :: ∀ w i. Node HTMLdiv w i
home props = div ([ class_ staticClass ] <> props)

home_ :: ∀ w i. Array (HTML w i) -> HTML w i
home_ = home []