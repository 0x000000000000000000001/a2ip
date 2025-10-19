module Component.Common.Separator.Style.Text.Text
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (border, color, darken, fontFamily, rem, sansSerif, solid)
import CSS as CSS
import Component.Common.Separator.Style.Util (grey)
import Data.NonEmpty ((:|))
import Util.Style (borderRadius1, fontSizePct, fontWeightBold, padding1, positionRelative, (.?))

classId :: String
classId = "wRKg6JrGY"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    border solid (rem 0.15) grey
    borderRadius1 0.5
    padding1 0.6
    color $ darken 0.15 grey
    fontWeightBold
    fontSizePct 110.0 
    fontFamily ["Oswald"] (sansSerif :| [])