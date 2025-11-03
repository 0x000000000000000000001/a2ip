module App.Component.Common.Input.Style.Field
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (nothing, (.?))

classId :: String
classId = "EC7ImB484"

style :: CSS.CSS
style = do
  classId .? do
    nothing
