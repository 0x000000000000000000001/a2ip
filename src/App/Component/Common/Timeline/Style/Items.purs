module App.Component.Common.Timeline.Style.Items
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (column, flexDirection)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, reflectStaticClass, justifyContentCenter, (.?))

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