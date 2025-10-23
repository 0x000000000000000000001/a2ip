module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (darken)
import CSS as CSS
import Util.Style (fill, loadingGrey, widthRem, (.?))

classId :: String
classId = "nyO0Zg17q"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 3.0
    fill $ darken 0.4 loadingGrey