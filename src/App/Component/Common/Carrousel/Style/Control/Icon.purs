module App.Component.Common.Carrousel.Style.Control.Icon
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStatelessClass, positionRelative, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative