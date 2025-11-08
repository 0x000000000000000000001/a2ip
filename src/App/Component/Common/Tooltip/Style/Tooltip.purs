module App.Component.Common.Tooltip.Style.Tooltip
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Tooltip.Style.Outer.Outer as Outer
import CSS (hover)
import CSS as CSS
import Util.Style.Style (displayInlineBlock, displayNone, nothing, positionRelative, reflectStaticClass, (.&), (.?), (.|*.), (:?), (|*.))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative

  a___outer :? do
    displayInlineBlock
    displayNone

  __hover :? do 
    nothing

  b___outer :? do
    displayInlineBlock

  where 
  a___outer = classId .|*. Outer.classId
  __hover = classId .& hover
  b___outer = __hover |*. Outer.classId
