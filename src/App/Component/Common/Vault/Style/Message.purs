module App.Component.Common.Vault.Style.Message
  ( staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (color, white, zIndex)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, reflectStaticClass, positionRelative, textAlignCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    color white
    widthPct100
    textAlignCenter
    positionRelative
    zIndex 5

message :: ∀ w i. Node HTMLdiv w i
message props = div ([ class_ staticClass ] <> props)

message_ :: ∀ w i. Array (HTML w i) -> HTML w i
message_ = message []