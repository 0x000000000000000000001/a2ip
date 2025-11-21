module Ui.Component.Common.Vault.Style.Door
  ( door
  , door_
  , staticClass
  , staticClassWhenLeft
  , staticClassWhenRight
  , style
  )
  where

import Proem hiding (div, top)

import CSS (backgroundColor, rgba, zIndex)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, IProp, Node, div)
import Util.Proxy.Dictionary.Left (left_)
import Util.Proxy.Dictionary.Right (right_)
import Util.Style.Style (classes, heightPct100, refineClass', reflectStaticClass, topLeftToTopLeft, topRightToTopRight, widthPct, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenLeft :: String
staticClassWhenLeft = refineClass' staticClass left_

staticClassWhenRight :: String
staticClassWhenRight = refineClass' staticClass right_

style :: CSS.CSS
style = do
  staticClass .? do
    backgroundColor $ rgba 0 0 0 0.75
    widthPct 50.0
    heightPct100
    zIndex 4

  staticClassWhenLeft .? do 
    topLeftToTopLeft

  staticClassWhenRight .? do
    topRightToTopRight

door :: ∀ w i. Boolean -> Array (IProp HTMLdiv i) -> HTML w i
door left props = div ([ classes [ staticClass, left ? staticClassWhenLeft ↔ staticClassWhenRight ] ] <> props) []

door_ :: ∀ w i. Boolean -> HTML w i
door_ left = door left []
