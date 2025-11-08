module App.Component.Common.Vault.Style.Message
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (color, white, zIndex)
import CSS as CSS
import Util.Style.Style (reflectStaticClass, positionRelative, textAlignCenter, widthPct100, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    color white
    widthPct100
    textAlignCenter
    positionRelative
    zIndex 5