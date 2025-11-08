module App.Component.Common.Input.Style.Input
  ( statelessClass
  , statelessClassWhenOpen
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Label as Label
import CSS (position, relative, rem, transform, translate)
import CSS as CSS
import Util.Style.Style (colorRed, fontSizePct, nothing, refineClass', reflectStatelessClass, top0, (.?), (.|*.), (:?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

statelessClassWhenOpen :: String
statelessClassWhenOpen = refineClass' statelessClass "open"

style :: CSS.CSS
style = do
  statelessClass .? do
    position relative

  statelessClassWhenOpen .? do 
    nothing

  __label :? do 
    top0
    transform $ translate (rem 0.6) (rem 0.2)
    fontSizePct 80.0
    colorRed

  where 
  __label = statelessClassWhenOpen .|*. Label.statelessClass
