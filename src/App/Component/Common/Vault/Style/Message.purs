module App.Component.Common.Vault.Style.Message
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (color, white, zIndex)
import CSS as CSS
import Util.Style.Style (reflectStaticClass, positionRelative, textAlignCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    color white
    widthPct100
    textAlignCenter
    positionRelative
    zIndex 5