module App.Component.Page.Seminars.Style.Timeline.Label.Names
  ( names
  , names_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS (alignItems, column, flexDirection, flexEnd)
import CSS as CSS
import CSS.TextAlign (endTextAlign, textAlign)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, displayFlex, flexGrow1, flexWrap, justifyContentCenter, marginRight, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItems flexEnd
    flexWrap
    flexDirection column
    flexGrow1
    textAlign endTextAlign
    marginRight 0.8

names :: ∀ w i. Node HTMLdiv w i
names props = div ([ class_ staticClass ] <> props)

names_ :: ∀ w i. Array (HTML w i) -> HTML w i
names_ = names []
