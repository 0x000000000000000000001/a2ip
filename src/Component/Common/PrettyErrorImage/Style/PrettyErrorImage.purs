module Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS as CSS
import Util.Style (displayFlex, (.?))

classId :: String
classId = "w2aEZlO9q"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    