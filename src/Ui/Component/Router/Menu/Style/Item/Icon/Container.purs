module App.Component.Router.Menu.Style.Item.Icon.Container
  ( boxShadow
  , class'
  , container
  , container_
  , staticClass
  , style
  , width
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu as MenuStyle
import App.Component.Router.Menu.Type (State)
import CSS (alignSelf, backgroundColor, rem, rgba, white)
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import DOM.HTML.Indexed (HTMLdiv)
import Data.NonEmpty (singleton)
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (borderRadiusPct50, classes, displayFlex, heightRem, inferClass, justifyContentCenter, marginLeft, minWidthRem, reflectStaticClass, widthRem, (.?))

width :: Number
width = 3.2

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

boxShadow :: Number -> Number -> CSS.CSS
boxShadow x y = CSS.boxShadow $ singleton $ bsColor white $ shadow (rem x) (rem y)

style :: State -> CSS.CSS
style { id, unfold } = do
  staticClass .? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadiusPct50
    minWidthRem width
    widthRem width
    heightRem width
    marginLeft $ (MenuStyle.foldWidth - width) / 2.0
    displayFlex
    justifyContentCenter
    alignSelf center

  class' id .? do 
    when unfold $ boxShadow 0.12 0.12

container :: ∀ w i. String -> Node HTMLdiv w i
container id props = div ([ classes [staticClass, class' id] ] <> props)

container_ :: ∀ w i. String -> Array (HTML w i) -> HTML w i
container_ id = container id []