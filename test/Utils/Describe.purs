module Test.Utils.Describe
  ( describe
  ) where

import Prelude

import Test.Spec as TestSpec
import Test.Spec (Spec)

foreign import _describe :: Unit -> String

describe :: Spec Unit -> Spec Unit
describe specs = TestSpec.describe (_describe unit) specs
