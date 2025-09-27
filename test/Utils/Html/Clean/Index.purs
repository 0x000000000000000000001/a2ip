module Test.Utils.Html.Clean.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Clean.FindUnescapedQuote as FindUnescapedQuote
import Test.Utils.Html.Clean.RemoveAttribute as RemoveAttribute
import Test.Utils.Html.Clean.RemoveDataAttributes as RemoveDataAttributes

spec :: Spec Unit
spec = do
  FindUnescapedQuote.spec
  RemoveAttribute.spec
  RemoveDataAttributes.spec