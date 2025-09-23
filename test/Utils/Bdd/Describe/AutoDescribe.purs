module Test.Utils.Bdd.Describe
  ( autoDescribe
  ) where

import Prelude

import Test.Spec (Spec, describe)

foreign import getCallerModuleName :: Boolean -> Boolean -> String

autoDescribe :: Boolean -> Boolean -> String -> Spec Unit -> Spec Unit
autoDescribe full lowerFirst prefix specs = describe "" $ describe (prefix <> getCallerModuleName full lowerFirst) specs
