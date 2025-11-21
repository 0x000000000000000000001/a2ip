module Ui.Component.Common.Timeline.Style.Line
  ( line
  , line_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import Ui.Component.Common.Timeline.Style.Util (grey)
import CSS (backgroundColor)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, IProp, div)
import Util.Style.Style (class_, borderRadiusRem1, reflectStaticClass, heightPct100, topCenterToTopCenter, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    topCenterToTopCenter
    widthRem 0.24
    borderRadiusRem1 1.0
    backgroundColor grey
    heightPct100

line :: ∀ w i.Array (IProp HTMLdiv i) -> HTML w i
line props = div ([ class_ staticClass ] <> props) []

line_ :: ∀ w i. HTML w i
line_ = line []