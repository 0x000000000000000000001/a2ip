module App.Component.Common.Input.Style.Input
  ( classId
  , classIdWithFocus
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Label as Label
import CSS (position, relative, rem, transform, translate)
import CSS as CSS
import Util.Proxy.Dictionary.Focus (focus_)
import Util.Style (colorRed, fontSizePct, nothing, refine, reflectHashModuleName, top0, (.?), (.|*.), (:?))

classId :: String
classId = reflectHashModuleName ι

classIdWithFocus :: String
classIdWithFocus = refine classId focus_

style :: CSS.CSS
style = do
  classId .? do
    position relative

  classIdWithFocus .? do 
    nothing

  __label :? do 
    top0
    transform $ translate (rem 0.6) (rem 0.2)
    fontSizePct 80.0
    colorRed  

  where 
  __label = classIdWithFocus .|*. Label.classId
