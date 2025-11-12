module App.Component.Common.Input.Style.Label
  ( label
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (cursor, pct, rem, transform, translate)
import CSS as CSS
import CSS.Cursor (text)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (Node, div)
import Util.Style.Style (class_, reflectStaticClass, left0, positionAbsolute, topPct50, userSelectNone, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionAbsolute
    topPct50
    left0
    transform $ translate (rem 0.8) (pct $ -50.0)
    cursor text
    userSelectNone

label :: ∀ w i. Node HTMLdiv w i
label props = div ([ class_ staticClass ] <> props)
