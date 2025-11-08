module App.Component.Common.Loader.Style.Loader
  ( class'
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStatelessClass, nothing, positionRelative, (.?))

class' :: String
class' = reflectStatelessClass ι

-- | This wrapper is useful when we want to position the loader
-- | without interfering with its animation.
style :: CSS.CSS
style = do
  class' .? do
    positionRelative -- For zIndex customization