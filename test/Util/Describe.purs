module Test.Util.Describe
  ( describe
  , describeOnly
  ) where

import Proem

import Test.Spec (class FocusWarning, SpecT)
import Test.Spec as TestSpec
import Util.Module (reflectModuleName)

generateDescription :: Unit -> String 
generateDescription _ = reflectModuleName ι <> ":"

describe :: 
  ∀ m g i a
   . Monad m
  => SpecT g i m a
  -> SpecT g i m a
describe specs = TestSpec.describe (generateDescription ι) specs

describeOnly 
  :: ∀ m g i a
   . FocusWarning
  => Monad m
  => SpecT g i m a
  -> SpecT g i m a
describeOnly specs = TestSpec.describeOnly (generateDescription ι) specs
