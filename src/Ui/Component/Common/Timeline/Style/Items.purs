module Ui.Component.Common.Timeline.Style.Items
  ( items
  , items_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (column, flexDirection)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, alignItemsCenter, displayFlex, reflectStaticClass, justifyContentCenter, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column

items :: ∀ w i. Node HTMLdiv w i
items props = div ([ class_ staticClass ] <> props)

items_ :: ∀ w i. Array (HTML w i) -> HTML w i
items_ = items []