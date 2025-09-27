module Test.Utils.Html.Clean.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Clean.RemoveAttribute as RemoveAttribute

spec :: Spec Unit
spec = do
  RemoveAttribute.spec