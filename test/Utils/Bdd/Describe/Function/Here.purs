module Test.Utils.Bdd.Describe.Function.Here
  ( here
  ) where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.AutoDescribe (autoDescribe)

here :: Spec Unit -> Spec Unit
here = autoDescribe false true ":: "