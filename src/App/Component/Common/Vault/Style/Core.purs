module App.Component.Common.Vault.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (zIndex)
import CSS as CSS
import Util.Style.Style (reflectStatelessClass, positionRelative, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    zIndex 2