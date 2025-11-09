module App.Component.Page.About.Style.Card.Names
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (colorRed, fontSizePct, fontWeightBold, reflectStaticClass, raw, widthPct, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    fontWeightBold
    fontSizePct 140.0
    colorRed
    widthPct 80.0
    raw "transition" "background-color 0s; color 0s"