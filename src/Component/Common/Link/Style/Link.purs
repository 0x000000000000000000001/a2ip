module Component.Common.Link.Style.Link
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (Display, display, noneTextDecoration, textDecoration)
import CSS as CSS
import Util.Style ((.?))

classId :: String
classId = "PDme34MR8"

style :: Display -> CSS.CSS
style display_ = do
  classId .? do
    display display_
    textDecoration noneTextDecoration