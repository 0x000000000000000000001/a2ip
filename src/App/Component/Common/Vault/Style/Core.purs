module App.Component.Common.Vault.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (zIndex)
import CSS as CSS
import Util.Style.Style (reflectHashModuleName, positionRelative, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    zIndex 2