module Ui.Component.Common.Vault.Style.Core
  ( core
  , core_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (zIndex)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, reflectStaticClass, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    zIndex 2

core :: ∀ w i. Node HTMLdiv w i
core props = div ([ class_ staticClass ] <> props)

core_ :: ∀ w i. Array (HTML w i) -> HTML w i
core_ = core []