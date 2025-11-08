module App.Component.Common.Input.Style.Field
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (black, border, borderBottom, borderColor, outline, rem, solid)
import CSS as CSS
import Util.Style.Style (borderRadiusRem1, focus, fontSizeRem, reflectStaticClass, loadingGrey, overflowHidden, padding4, red, (.&), (.?), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
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
  __focus = staticClass .& focus
