module Component.Common.Separator.Style.Text
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (border, color, darken, fontSize, rem, solid)
import CSS as CSS
import Util.Style (borderRadius1, fontWeightBold, loadingGrey, padding1, red, (.?))

classId :: String
classId = "wRKg6JrGY"

style :: CSS.CSS
style = do
  classId .? do
    border solid (rem 0.15) $ darken 0.2 loadingGrey
    borderRadius1 0.5
    padding1 0.6
    color $ darken 0.1 $ darken 0.4 loadingGrey
    fontWeightBold
    fontSize 