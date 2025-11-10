module App.Component.Common.Input.Style.Input
  ( staticClass
  , staticClassWhenOpen
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Label as Label
import CSS (position, relative, rem, transform, translate)
import CSS as CSS
import Util.Style.Style (colorRed, fontSizePct, noCss, refineClass', reflectStaticClass, top0, (.?), (.|*.), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenOpen :: String
staticClassWhenOpen = refineClass' staticClass "open"

style :: CSS.CSS
style = do
  staticClass .? do
    position relative

  staticClassWhenOpen .? do 
    noCss

  __label :? do 
    top0
    transform $ translate (rem 0.8) (rem 0.6)
    fontSizePct 80.0
    colorRed

  where 
  __label = staticClassWhenOpen .|*. Label.staticClass
