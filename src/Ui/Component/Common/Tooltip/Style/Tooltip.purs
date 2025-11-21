module Ui.Component.Common.Tooltip.Style.Tooltip
  ( staticClass
  , style
  , tooltip
  , tooltip_
  )
  where

import Proem hiding (div, top)

import Ui.Component.Common.Tooltip.Style.Outer.Outer as Outer
import CSS (hover)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, displayInlineBlock, displayNone, noCss, positionRelative, reflectStaticClass, (.&), (.?), (.|*.), (:?), (|*.))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative

  __outer :? do
    displayNone

  __hover :? do 
    noCss

  ____outer :? do
    displayInlineBlock

  where 
  __outer = staticClass .|*. Outer.staticClass
  __hover = staticClass .& hover
  ____outer = __hover |*. Outer.staticClass

tooltip :: ∀ w i. Node HTMLdiv w i
tooltip props = div ([ class_ staticClass ] <> props)

tooltip_ :: ∀ w i. Array (HTML w i) -> HTML w i
tooltip_ = tooltip []