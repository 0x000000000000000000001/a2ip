module App.Component.Common.Vault.Style.Door
  ( staticClass
  , staticClassWhenLeft
  , staticClassWhenRight
  , style
  )
  where

import Proem hiding (div, top)

import CSS (backgroundColor, rgba, zIndex)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Proxy.Dictionary.Left (left_)
import Util.Proxy.Dictionary.Right (right_)
import Util.Style.Style (class_, heightPct100, refineClass', reflectStaticClass, topLeftToTopLeft, topRightToTopRight, widthPct, (.?))

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

door :: ∀ w i. Node HTMLdiv w i
door props = div ([ class_ staticClass ] <> props)

door_ :: ∀ w i. Array (HTML w i) -> HTML w i
door_ = door []
