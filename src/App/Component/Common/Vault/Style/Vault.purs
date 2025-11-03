module App.Component.Common.Vault.Style.Vault
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, backgroundColor, flexStart, rgba)
import CSS as CSS
import Util.Style (displayFlex, justifyContentCenter, (.?))

classId :: String
classId = "p7POPu5N1"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignItems flexStart
    backgroundColor $ rgba 0 0 0 0.75