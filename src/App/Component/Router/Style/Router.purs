module App.Component.Router.Style.Router
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (minHeight, vh)
import CSS as CSS
import Util.Style (displayFlex, (.?))

classId :: String
classId = "DDGK8gCXg"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    minHeight (vh 100.0)