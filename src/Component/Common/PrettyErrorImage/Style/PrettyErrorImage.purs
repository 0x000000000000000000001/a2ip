module Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( classIdWhenErrored
  , style
  ) where

import Prelude hiding (top)

import CSS (backgroundColor, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, loadingGrey, (.?))

classIdWhenErrored :: String
classIdWhenErrored = "w2aEZlO9q"

style :: CSS.CSS
style = do
  classIdWhenErrored .? do
    displayFlex
    justifyContent center
    backgroundColor loadingGrey