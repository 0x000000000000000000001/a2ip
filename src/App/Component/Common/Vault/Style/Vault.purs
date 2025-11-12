module App.Component.Common.Vault.Style.Vault
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, reflectStaticClass, justifyContentCenter, positionRelative, (.?))

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