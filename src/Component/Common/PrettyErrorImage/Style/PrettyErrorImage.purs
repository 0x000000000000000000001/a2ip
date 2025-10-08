module Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS as CSS
import Util.Style (displayFlex, (.?))

classId :: String
classId = "DPG2dLnZb"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    