module App.Component.Common.Vault.Style.Core
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (zIndex)
import CSS as CSS
import Util.Style.Style (reflectStaticClass, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    zIndex 2

core :: ∀ w i. Node HTMLdiv w i
core props = div ([ class_ staticClass ] <> props)

core_ :: ∀ w i. Array (HTML w i) -> HTML w i
core_ = core []