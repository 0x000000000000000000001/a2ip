module Test.Utils.Bdd.Describe.Here
  ( here
  ) where

import Prelude

import Test.Spec (Spec, describe)

foreign import _here :: Unit -> String

here :: Spec Unit -> Spec Unit
here specs = describe (_here unit) specs
