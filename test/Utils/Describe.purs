module Test.Utils.Describe 
  ( autoDescribe
  ) where

import Prelude
import Test.Spec (Spec, describe)

foreign import getCallerModuleName :: Unit -> String

autoDescribe :: Spec Unit -> Spec Unit
autoDescribe specs = describe "" $ describe (getCallerModuleName unit) specs