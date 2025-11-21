module App.Component.Router.Style.Core
  ( core
  , core_
  , staticClass
  , style
  , zIndex
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as Menu
import CSS as CSS
import DOM.HTML.Indexed (HTMLmain)
import Halogen.HTML (HTML, Node, main)
import Util.Style.Style (backgroundColorWhite, borderRadiusRem1, class_, displayFlex, flexGrow1, margin4, padding1, positionRelative, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

zIndex :: Int
zIndex = Menu.zIndex - 10

style :: CSS.CSS
style = do
  staticClass .? do
    margin4 2.0 2.0 2.0 $ 2.0 + Menu.foldWidth
    displayFlex
    backgroundColorWhite
    padding1 1.0
    borderRadiusRem1 0.6
    flexGrow1
    positionRelative
    CSS.zIndex zIndex

core :: ∀ w i. Node HTMLmain w i
core props = main ([ class_ staticClass ] <> props)

core_ :: ∀ w i. Array (HTML w i) -> HTML w i
core_ = core []