module Test.Utils.Bdd.Describe.Module.Here
  ( here
  ) where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.AutoDescribe (autoDescribe)

here :: Spec Unit -> Spec Unit
here = autoDescribe true false ""