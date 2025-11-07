module App.Component.Common.Input.Style.Input
  ( classId
  , classIdWhenOpen
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Label as Label
import CSS (position, relative, rem, transform, translate)
import CSS as CSS
import Util.Style.Style (colorRed, fontSizePct, nothing, refineClass, reflectHashModuleName, top0, (.?), (.|*.), (:?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenOpen :: String
classIdWhenOpen = refineClass classId "open"

style :: CSS.CSS
style = do
  classId .? do
    position relative

  classIdWhenOpen .? do 
    nothing

  __label :? do 
    top0
    transform $ translate (rem 0.6) (rem 0.2)
    fontSizePct 80.0
    colorRed  

  where 
  __label = classIdWhenOpen .|*. Label.classId
