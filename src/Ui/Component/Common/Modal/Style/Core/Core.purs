module Ui.Component.Common.Modal.Style.Core.Core
  ( core
  , core_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import Ui.Component.Router.Menu.Style.Menu as Menu
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (class_, backgroundColorWhite, borderRadiusRem1, margin2, padding1, positionRelative, reflectStaticClass, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    backgroundColorWhite
    widthRem 60.0
    padding1 2.0
    borderRadiusRem1 0.5
    margin2 8.0 2.0

  Menu.staticClass .? do
    CSS.zIndex $ -1

core :: ∀ w i. Node HTMLdiv w i
core props = div ([ class_ staticClass ] <> props)

core_ :: ∀ w i. Array (HTML w i) -> HTML w i
core_ = core []