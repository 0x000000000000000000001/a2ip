module App.Component.Common.Separator.Style.Text.Text
  ( staticClass
  , style
  , text
  , text_
  )
  where

import Proem hiding (div, top)

import App.Component.Common.Separator.Style.Util (grey)
import CSS (borderLeft, borderRight, borderTop, color, darken, fontFamily, rem, sansSerif, solid)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Data.NonEmpty ((:|))
import Util.Style.Style (class_, borderRadiusRem4, displayInlineBlock, fontSizePct, fontWeightBold, reflectStaticClass, margin0, padding1, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayInlineBlock
    margin0
    positionRelative
    borderLeft solid (rem 0.15) grey
    borderTop solid (rem 0.15) grey
    borderRight solid (rem 0.15) grey
    borderRadiusRem4 0.5 0.5 0.0 0.0
    padding1 0.6
    color $ darken 0.15 grey
    fontWeightBold
    fontSizePct 110.0 
    fontFamily ["Oswald"] (sansSerif :| [])

text :: ∀ w i. Node HTMLdiv w i
text props = div ([ class_ staticClass ] <> props)

text_ :: ∀ w i. Array (HTML w i) -> HTML w i
text_ = text []