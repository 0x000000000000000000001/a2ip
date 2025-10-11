module Test.Util.Html.Clean.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Html.Clean.CleanAttributesInTag as CleanAttributesInTag
import Test.Util.Html.Clean.CleanAttributesInTags as CleanAttributesInTags
import Test.Util.Html.Clean.FindUnescapedQuote as FindUnescapedQuote
import Test.Util.Html.Clean.RemoveAttribute as RemoveAttribute
import Test.Util.Html.Clean.RemoveComments as RemoveComments
import Test.Util.Html.Clean.RemoveDataAttributes as RemoveDataAttributes
import Test.Util.Html.Clean.Untag as Untag
 
spec :: Spec Unit
spec = do
  CleanAttributesInTag.spec
  CleanAttributesInTags.spec
  FindUnescapedQuote.spec
  RemoveAttribute.spec
  RemoveComments.spec
  RemoveDataAttributes.spec
  Untag.spec