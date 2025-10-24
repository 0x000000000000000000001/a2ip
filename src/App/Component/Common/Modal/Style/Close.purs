module App.Component.Common.Modal.Style.Close
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (color, deg, hover, rotate, transforms, white)
import CSS as CSS
import CSS.Transform (scale)
import Util.Style (bottomLeftToTopRight, cursorPointer, fill, heightRem, nothing, padding1, userSelectNone, widthRem, (.&), (.?), (.|*¨), (:?), (|*¨))

classId :: String
classId = "FeG0FXVPw"

style :: CSS.CSS
style = do
  classId .? do
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
  __svg = classId .|*¨ "svg"
  __hover = classId .& hover
  ____svg = __hover |*¨ "svg"