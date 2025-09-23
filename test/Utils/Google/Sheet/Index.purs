module Test.Utils.Google.Sheet.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Bdd.Describe.Module.Here (here)
import Test.Utils.Google.Sheet.Html as Html 

spec :: Spec Unit
spec = here do
  Html.spec