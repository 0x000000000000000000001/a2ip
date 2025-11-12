module App.Component.Router.Menu.Style.Item.Children
  ( children
  , children_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu (backgroundBlackAlpha)
import CSS (backgroundColor, rgba)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, displayNone, flexWrap, reflectStaticClass, topLeftToTopRight, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    backgroundColor (rgba 0 0 0 backgroundBlackAlpha)
    topLeftToTopRight
    displayNone
    flexWrap
    widthPct100

children :: ∀ w i. Node HTMLdiv w i
children props = div ([ class_ staticClass ] <> props)

children_ :: ∀ w i. Array (HTML w i) -> HTML w i
children_ = children []