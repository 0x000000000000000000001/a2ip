module App.Component.Common.Link.Style.Link
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (Display, display, noneTextDecoration, textDecoration)
import CSS as CSS
import Util.Style.Style (reflectHashModuleName, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: Display -> CSS.CSS
style display_ = do
  classId .? do
    display display_
    textDecoration noneTextDecoration