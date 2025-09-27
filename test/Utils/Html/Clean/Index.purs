module Test.Utils.Html.Clean.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Clean.RemoveAttribute as RemoveAttribute
import Test.Utils.Html.Clean.RemoveDataAttributes as RemoveDataAttributes

spec :: Spec Unit
spec = do
  RemoveAttribute.spec
  RemoveDataAttributes.spec