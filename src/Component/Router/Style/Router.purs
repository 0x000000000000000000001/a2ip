module Component.Router.Style.Router
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (display, flex, flexDirection, minHeight, row, vh)
import CSS as CSS
import Utils.Style ((<?))

classId :: String
classId = "DDGK8gCXg"

style :: CSS.CSS
style = do
  classId <? do
    display flex
    flexDirection row
    minHeight (vh 100.0)