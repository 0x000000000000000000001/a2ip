module App.Component.Page.Seminars.Style.Poster
  ( poster
  , poster_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (alignItems, column, flexDirection)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import CSS.Common (center)
import Util.Style.Style (class_, displayFlex, flexGrow1, reflectStaticClass, justifyContentCenter, padding1, positionSticky, top0, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItems center
    flexDirection column
    widthRem 1.0
    flexGrow1
    positionSticky
    top0
    padding1 2.0

poster :: ∀ w i. Node HTMLdiv w i
poster props = div ([ class_ staticClass ] <> props)

poster_ :: ∀ w i. Array (HTML w i) -> HTML w i
poster_ = poster []