module App.Component.Common.Vault.Style.Core
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (zIndex)
import CSS as CSS
import Util.Style.Style (reflectStaticClass, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    zIndex 2