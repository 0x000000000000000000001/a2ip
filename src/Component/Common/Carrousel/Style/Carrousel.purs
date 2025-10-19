module Component.Common.Carrousel.Style.Carrousel
  ( classIdWhenErrored
  , style
  ) where

import Proem hiding (top)

import CSS (justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, (.?))

classIdWhenErrored :: String
classIdWhenErrored = "nX71efu91"

style :: CSS.CSS
style = do
  classIdWhenErrored .? do
    displayFlex
    justifyContent center