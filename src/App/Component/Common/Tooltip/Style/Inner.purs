module App.Component.Common.Tooltip.Style.Inner
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (noCss, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    noCss

inner :: ∀ w i. Node HTMLdiv w i
inner props = div ([ class_ staticClass ] <> props)

inner_ :: ∀ w i. Array (HTML w i) -> HTML w i
inner_ = inner []