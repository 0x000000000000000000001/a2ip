module App.Component.Common.Carrousel.Style.Control.Icon
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectHashModuleName, positionRelative, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative