module Test.Util.Html.Encoding.Index where

import Prelude

import Test.Spec (Spec)
import Test.Util.Html.Encode.DecodeHtmlEntities as DecodeHtmlEntities
import Test.Util.Html.Encode.EncodeHtmlEntities as EncodeHtmlEntities

spec :: Spec Unit
spec = do
  DecodeHtmlEntities.spec
  EncodeHtmlEntities.spec