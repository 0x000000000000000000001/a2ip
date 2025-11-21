module App.Component.Page.About.Style.Card.Names
  ( names
  , names_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, colorRed, fontSizePct, fontWeightBold, reflectStaticClass, raw, widthPct, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    fontWeightBold
    fontSizePct 140.0
    colorRed
    widthPct 80.0
    raw "transition" "background-color 0s; color 0s"

names :: ∀ w i. Node HTMLdiv w i
names props = div ([ class_ staticClass ] <> props)

names_ :: ∀ w i. Array (HTML w i) -> HTML w i
names_ = names []