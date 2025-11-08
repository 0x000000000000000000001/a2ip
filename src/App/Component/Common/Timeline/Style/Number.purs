module App.Component.Common.Timeline.Style.Number
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStaticClass, nothing, (.?))

classId :: String
classId = reflectStaticClass ι

style :: CSS.CSS
style = do
  classId .? do
    nothing