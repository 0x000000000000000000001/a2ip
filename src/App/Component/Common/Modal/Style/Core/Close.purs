module App.Component.Common.Modal.Style.Core.Close
  ( statelessClass
  , style
  )
  where

import Proem hiding (top)

import CSS (color, deg, hover, rotate, transforms, white, (|*))
import CSS as CSS
import CSS.Transform (scale)
import Util.Style.Style (bottomLeftToTopRight, cursorPointer, fill, heightRem, nothing, padding1, reflectHashModuleName, svg, userSelectNone, widthRem, (.&), (.?), (.|*), (:?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

style :: CSS.CSS
style = do
  statelessClass .? do
    color white
    bottomLeftToTopRight
    padding1 0.88
    cursorPointer
    userSelectNone

  __svg :? do 
    widthRem 3.0
    heightRem 3.0
    fill white

  __hover :? do
    nothing

  ____svg :? do
    transforms [ rotate $ deg 90.0, scale 1.5 1.5 ]

  where
  __svg = statelessClass .|* svg
  __hover = statelessClass .& hover
  ____svg = __hover |* svg