module App.Component.Common.Input.Style.Field
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Type (State)
import CSS (backgroundColor, borderColor, color, outlineWidth, rem, solid)
import CSS as CSS
import Util.Style.Style (borderBottomWidth, borderLeftWidth, borderRadiusRem1, borderRightWidth, borderStyle, borderTopWidth, focus, fontSizeRem, inferClass, loadingGrey, noCss, overflowHidden, padding4, placeholder, red, reflectStaticClass, (.&), (.?), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style 
  { id
  , input: 
      { style: 
          { backgroundColor: backgroundColor' 
          , textColor
          , placeholderColor
          , border
          } 
      } 
  } = do
  staticClass .? do
    fontSizeRem 1.0
    borderStyle solid
    padding4 1.6 0.7 0.8 0.7
    outlineWidth $ rem 0.0
    borderRadiusRem1 0.2
    overflowHidden
    
  __focus :? do
    borderColor red

  class' id .? do 
    backgroundColor' ?? backgroundColor ⇔ noCss
    borderColor $ border.color ??⇒ loadingGrey
    borderTopWidth $ border.width.top ??⇒ 0.0
    borderRightWidth $ border.width.right ??⇒ 0.0
    borderBottomWidth $ border.width.bottom ??⇒ 0.2
    borderLeftWidth $ border.width.left ??⇒ 0.0
    textColor ?? color ⇔ noCss

  __placeholder :? do
    placeholderColor ?? color ⇔ noCss

  where 
  __focus = staticClass .& focus
  __placeholder = class' id .& placeholder
