module App.Component.Common.Input.Style.Field
  ( statelessClass
  , style
  ) where

import Proem hiding (top)

import CSS (black, border, borderBottom, borderColor, outline, rem, solid)
import CSS as CSS
import Util.Style.Style (borderRadiusRem1, focus, fontSizeRem, reflectStatelessClass, loadingGrey, overflowHidden, padding4, red, (.&), (.?), (:?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    fontSizeRem 1.0
    border solid (rem 0.0) black
    borderBottom solid (rem 0.2) loadingGrey
    outline solid (rem 0.0) black
    padding4 1.4 0.6 0.8 0.6
    borderRadiusRem1 0.2
    overflowHidden
    
  __focus :? do
    borderColor red

  where 
  __focus = statelessClass .& focus
