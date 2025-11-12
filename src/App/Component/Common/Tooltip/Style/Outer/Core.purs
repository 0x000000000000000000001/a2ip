module App.Component.Common.Tooltip.Style.Outer.Core
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, color, rgba, white)
import CSS as CSS
import Util.Style.Style (borderRadiusRem1, overflowHidden, padding1, reflectStaticClass, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    backgroundColor $ rgba 0 0 0 0.9
    color white
    padding1 1.0
    borderRadiusRem1 0.3
    overflowHidden
    widthPct100

core :: ∀ w i. Node HTMLdiv w i
core props = div ([ class_ staticClass ] <> props)

core_ :: ∀ w i. Array (HTML w i) -> HTML w i
core_ = core []
