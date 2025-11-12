module App.Component.Common.Vault.Style.Vault
  ( staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (alignItems, flexStart)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, displayFlex, reflectStaticClass, justifyContentCenter, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    displayFlex
    justifyContentCenter
    alignItems flexStart

vault :: ∀ w i. Node HTMLdiv w i
vault props = div ([ class_ staticClass ] <> props)

vault_ :: ∀ w i. Array (HTML w i) -> HTML w i
vault_ = vault []