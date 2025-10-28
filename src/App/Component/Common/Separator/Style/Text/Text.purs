module App.Component.Common.Separator.Style.Text.Text
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (borderLeft, borderRight, borderTop, color, darken, fontFamily, rem, sansSerif, solid)
import CSS as CSS
import App.Component.Common.Separator.Style.Util (grey)
import Data.NonEmpty ((:|))
import Util.Style (borderRadiusRem4, displayInlineBlock, fontSizePct, fontWeightBold, margin0, padding1, positionRelative, (.?))

classId :: String
classId = "wRKg6JrGY"

style :: CSS.CSS
style = do
  classId .? do
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