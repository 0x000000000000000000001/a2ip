module App.Component.Common.Vault.Style.Front
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (topLeftToTopLeft, (.?))

classId :: String
classId = "j8djWsw23"

style :: CSS.CSS
style = do
  classId .? do
    topLeftToTopLeft