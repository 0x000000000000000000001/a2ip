module App.Component.Common.Input.Style.Field
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (black, border, borderBottom, borderColor, outline, rem, solid)
import CSS as CSS
import Util.Style (borderRadiusRem1, focus, fontSizeRem, loadingGrey, overflowHidden, padding2, red, (.&), (.?), (:?))

classId :: String
classId = "EC7ImB484"

style :: CSS.CSS
style = do
  classId .? do
    fontSizeRem 1.0
    border solid (rem 0.0) black
    borderBottom solid (rem 0.2) loadingGrey
    outline solid (rem 0.0) black
    padding2 0.6 0.4
    borderRadiusRem1 0.2
    overflowHidden
    
  -- __focus :? do
  --   borderColor red

  where 
  __focus = classId .& focus
