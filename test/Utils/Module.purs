module Test.Utils.Module (detectTestModuleNamePrefix) where

import Prelude
import Effect (Effect)

foreign import detectTestModuleNamePrefix :: Unit -> Effect String
