module Component.Common.Separator.Style.Text
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (border, color, darken, rem, solid)
import CSS as CSS
import Util.Style (borderRadius1, fontSizePct, fontWeightBold, loadingGrey, padding1, (.?))

classId :: String
classId = "wRKg6JrGY"

style :: CSS.CSS
style = do
  classId .? do
    border solid (rem 0.15) $ darken 0.16 loadingGrey
    borderRadius1 0.5
    padding1 0.6
    color $ darken 0.1 $ darken 0.24 loadingGrey
    fontWeightBold
    fontSizePct 110.0 