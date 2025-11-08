module App.Component.Common.Tooltip.Style.Inner
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (nothing, reflectStaticClass, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    nothing
