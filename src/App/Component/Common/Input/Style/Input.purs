module App.Component.Common.Input.Style.Input
  ( classId
  , classIdWithFocus
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Label as Label
import CSS (marginBottom, position, px, relative, rem, transform, translate, width)
import CSS as CSS
import Util.Style (colorRed, fontSizePct, nothing, top0, (.?), (.|*.), (:?))

classId :: String
classId = "arRAAae18"

classIdWithFocus :: String
classIdWithFocus = "Po0mMicGl"

style :: CSS.CSS
style = do
  classId .? do
    position relative
    marginBottom (px 16.0)
    width (px 300.0)

  classIdWithFocus .? do 
    nothing

  __label :? do 
    top0
    transform $ translate (rem 0.4) (rem 0.2)
    fontSizePct 80.0
    colorRed  

  where 
  __label = classIdWithFocus .|*. Label.classId
