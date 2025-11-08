module App.Component.Common.Carrousel.Style.Control.Icon
  ( statelessClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStatelessClass, positionRelative, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    positionRelative