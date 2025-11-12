module App.Component.Common.Modal.Style.Core.Close
  ( staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (color, deg, hover, rotate, transforms, white, (|*))
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import CSS.Transform (scale)
import Util.Style.Style (class_, bottomLeftToTopRight, cursorPointer, fill, heightRem, noCss, padding1, reflectStaticClass, svg, userSelectNone, widthRem, (.&), (.?), (.|*), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
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
    noCss

  ____svg :? do
    transforms [ rotate $ deg 90.0, scale 1.5 1.5 ]

  where
  __svg = staticClass .|* svg
  __hover = staticClass .& hover
  ____svg = __hover |* svg

close :: ∀ w i. Node HTMLdiv w i
close props = div ([ class_ staticClass ] <> props)

close_ :: ∀ w i. Array (HTML w i) -> HTML w i
close_ = close []