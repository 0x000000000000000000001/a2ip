module App.Component.Router.Menu.Style.Item.Icon.Icon
  ( icon
  , icon_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import CSS (fromString, key)
import CSS as CSS
import DOM.HTML.Indexed (HTMLimg)
import Halogen.HTML (HTML, Leaf, img)
import Util.Style.Style (class_, margin1, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    margin1 0.8
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"
  
icon :: ∀ w i. Leaf HTMLimg w i
icon props = img ([ class_ staticClass ] <> props)

icon_ :: ∀ w i. HTML w i
icon_ = icon []