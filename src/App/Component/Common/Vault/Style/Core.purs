module App.Component.Common.Vault.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (nothing, (.?))

classId :: String
classId = "CmV9tUiDz"

style :: CSS.CSS
style = do
  classId .? do
    nothing