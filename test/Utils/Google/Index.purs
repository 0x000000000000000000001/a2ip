module Test.Utils.Google.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.Describe.Module.Here (here)
import Test.Utils.Google.Drive as Drive
import Test.Utils.Google.Sheet as Sheet

spec :: Spec Unit
spec = here do
  Drive.spec
  Sheet.spec 