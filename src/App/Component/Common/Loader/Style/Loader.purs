module App.Component.Common.Loader.Style.Loader
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStatelessClass, nothing, positionRelative, (.?))

classId :: String
classId = reflectStatelessClass ι

-- | This wrapper is useful when we want to position the loader
-- | without interfering with its animation.
style :: CSS.CSS
style = do
  classId .? do
    positionRelative -- For zIndex customization
    nothing