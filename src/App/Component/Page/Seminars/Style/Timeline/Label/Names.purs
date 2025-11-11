module App.Component.Page.Seminars.Style.Timeline.Label.Names
  ( names
  , names_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS (flexEnd, justifyContent)
import CSS as CSS
import CSS.TextAlign (endTextAlign, textAlign)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (alignItemsCenter, class_, displayFlex, flexGrow1, flexWrap, marginRight, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContent flexEnd
    alignItemsCenter
    flexWrap
    flexGrow1
    textAlign endTextAlign
    marginRight 0.8

names :: ∀ w i. Node HTMLdiv w i
names props = div ([ class_ staticClass ] <> props)

names_ :: ∀ w i. Array (HTML w i) -> HTML w i
names_ = names []
