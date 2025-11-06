module App.Component.Common.Tooltip.Style.Tooltip
  ( classId
  , classIdWhenOpen
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (nothing, refineClassId, reflectHashModuleName, (.?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenOpen :: String
classIdWhenOpen = refineClassId classId "open"

style :: CSS.CSS
style = do
  classId .? do
    nothing
