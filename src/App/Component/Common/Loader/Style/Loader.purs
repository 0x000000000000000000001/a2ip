module App.Component.Common.Loader.Style.Loader
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (positionRelative, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

-- | This wrapper is useful when we want to position the loader
-- | without interfering with its animation.
style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative -- For zIndex customization

loader :: ∀ w i. Node HTMLdiv w i
loader props = div ([ class_ staticClass ] <> props)

loader_ :: ∀ w i. Array (HTML w i) -> HTML w i
loader_ = loader []