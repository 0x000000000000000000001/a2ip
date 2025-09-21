module Test.Utils.Describe
  ( autoDescribeModule
  , autoDescribeFunction
  ) where

import Prelude

import Test.Spec (Spec, describe)

foreign import getCallerModuleName :: Boolean -> Boolean -> String

autoDescribe :: Boolean -> Boolean -> String -> Spec Unit -> Spec Unit
autoDescribe full lowerFirst prefix specs = describe "" $ describe (prefix <> getCallerModuleName full lowerFirst) specs

autoDescribeModule :: Spec Unit -> Spec Unit
autoDescribeModule = autoDescribe true false ""

autoDescribeFunction :: Spec Unit -> Spec Unit
autoDescribeFunction = autoDescribe false true ":: "