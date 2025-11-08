module App.Component.Common.Vault.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (zIndex)
import CSS as CSS
import Util.Style.Style (reflectStaticClass, positionRelative, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    zIndex 2