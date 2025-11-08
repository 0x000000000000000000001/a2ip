module App.Component.Common.Separator.Style.Text.Text
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import App.Component.Common.Separator.Style.Util (grey)
import CSS (borderLeft, borderRight, borderTop, color, darken, fontFamily, rem, sansSerif, solid)
import CSS as CSS
import Data.NonEmpty ((:|))
import Util.Style.Style (borderRadiusRem4, displayInlineBlock, fontSizePct, fontWeightBold, reflectStaticClass, margin0, padding1, positionRelative, (.?))

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