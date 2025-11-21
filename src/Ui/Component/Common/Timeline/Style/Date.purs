module App.Component.Common.Timeline.Style.Date
  ( date
  , date_
  , fontSizePct
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS (alignItems, color, column, flexDirection, flexEnd)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Color (darken)
import Util.Style.Style (class_, centerRightToCenterWithRemDelta, displayFlex, justifyContentCenter, reflectStaticClass, userSelectNone, (.?))
import Util.Style.Style as UtilStyle

staticClass :: String
staticClass = reflectStaticClass ι

fontSizePct :: Number 
fontSizePct = 110.0

style :: CSS.CSS
style = do
  staticClass .? do
    centerRightToCenterWithRemDelta (-1.4) 0.0
    displayFlex
    justifyContentCenter
    alignItems flexEnd
    flexDirection column
    UtilStyle.fontSizePct fontSizePct
    userSelectNone
    color $ darken 0.3 grey

date :: ∀ w i. Node HTMLdiv w i
date props = div ([ class_ staticClass ] <> props)

date_ :: ∀ w i. Array (HTML w i) -> HTML w i
date_ = date []