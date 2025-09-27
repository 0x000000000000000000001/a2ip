module Test.Utils.Html.Clean.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Clean.CleanAttributesInTag as CleanAttributesInTag
import Test.Utils.Html.Clean.CleanAttributesInTags as CleanAttributesInTags
import Test.Utils.Html.Clean.FindUnescapedQuote as FindUnescapedQuote
import Test.Utils.Html.Clean.RemoveAttribute as RemoveAttribute
import Test.Utils.Html.Clean.RemoveDataAttributes as RemoveDataAttributes

spec :: Spec Unit
spec = do
  CleanAttributesInTag.spec
  CleanAttributesInTags.spec
  FindUnescapedQuote.spec
  RemoveAttribute.spec
  RemoveDataAttributes.spec