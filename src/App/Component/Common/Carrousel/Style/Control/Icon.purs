module App.Component.Common.Carrousel.Style.Control.Icon
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStaticClass, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative