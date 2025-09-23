module Test.Utils.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.Describe.Module.Here (here)
import Test.Utils.Google as Google

spec :: Spec Unit
spec = here do
  Google.spec 