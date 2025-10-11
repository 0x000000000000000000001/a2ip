module Component.Common.Link.Style.Link
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (textDecoration, noneTextDecoration)
import CSS as CSS
import Util.Style (displayInlineBlock, (.?))

classId :: String
classId = "PDme34MR8"

style :: CSS.CSS
style = do
  classId .? do
    displayInlineBlock
    textDecoration noneTextDecoration