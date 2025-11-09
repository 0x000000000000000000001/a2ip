module App.Component.Common.Tooltip.Style.Tooltip
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Tooltip.Style.Outer.Outer as Outer
import CSS (hover)
import CSS as CSS
import Util.Style.Style (displayInlineBlock, displayNone, nothing, positionRelative, reflectStaticClass, (.&), (.?), (.|*.), (:?), (|*.))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative

  a___outer :? do
    displayInlineBlock
    displayNone

  __hover :? do 
    nothing

  b___outer :? do
    displayInlineBlock

  where 
  a___outer = staticClass .|*. Outer.staticClass
  __hover = staticClass .& hover
  b___outer = __hover |*. Outer.staticClass
