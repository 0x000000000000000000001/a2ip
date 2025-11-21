module Ui.Component.Router.Menu.Style.Logo
  ( logo
  , logo_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import Ui.Component.Router.Menu.Style.Item.Icon.Container as ItemIconContainer
import CSS (alignSelf, fromString, key)
import CSS as CSS
import CSS.Common (center)
import DOM.HTML.Indexed (HTMLimg)
import Halogen.HTML (HTML, Leaf, img)
import Util.Style.Style (class_, cursorPointer, margin4, reflectStaticClass, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    widthRem $ ItemIconContainer.width * 1.2
    margin4 1.4 1.0 1.0 1.0
    key (fromString "filter") "invert(1)"
    cursorPointer
    alignSelf center

logo :: ∀ w i. Leaf HTMLimg w i
logo props = img ([ class_ staticClass ] <> props)

logo_ :: ∀ w i. HTML w i
logo_ = logo []