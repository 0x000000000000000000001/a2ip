module App.Component.Common.Vault.Style.Vault
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, reflectStaticClass, justifyContentCenter, positionRelative, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    alignItems flexStart