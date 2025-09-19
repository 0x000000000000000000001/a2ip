module Component.Page.About.Style.About
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (alignContent, display, flex, flexStart, flexWrap, justifyContent, wrap)
import CSS as CSS
import CSS.Common (center)
import Utils.Style (padding, (.?))

classId :: String
classId = "mH916ksxM"

style :: CSS.CSS
style = do
  classId .? do
    display flex
    justifyContent center
    alignContent flexStart
    flexWrap wrap
    padding 1.3