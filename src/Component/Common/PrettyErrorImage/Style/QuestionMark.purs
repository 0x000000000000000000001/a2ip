module Component.Common.PrettyErrorImage.Style.QuestionMark
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (darken)
import CSS as CSS
import Color (toHexString)
import Util.Style (loadingGrey, raw, widthRem, (.?))

classId :: String
classId = "nyO0Zg17q"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 3.0
    raw "fill" $ toHexString $ darken 0.4 loadingGrey