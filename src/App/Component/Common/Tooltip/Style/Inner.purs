module App.Component.Common.Tooltip.Style.Inner
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (nothing, reflectHashModuleName, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    nothing
