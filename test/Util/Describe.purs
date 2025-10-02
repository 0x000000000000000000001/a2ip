module Test.Utils.Describe
  ( describe
  , describeOnly
  ) where

import Prelude

import Test.Spec (class FocusWarning, SpecT)
import Test.Spec as TestSpec

foreign import captureModuleName :: Unit -> String

generateDescription :: Unit -> String 
generateDescription _ = captureModuleName unit <> ":"

describe :: 
  forall m g i a
   . Monad m
  => SpecT g i m a
  -> SpecT g i m a
describe specs = TestSpec.describe (generateDescription unit) specs

describeOnly 
  :: forall m g i a
   . FocusWarning
  => Monad m
  => SpecT g i m a
  -> SpecT g i m a
describeOnly specs = TestSpec.describeOnly (generateDescription unit) specs
