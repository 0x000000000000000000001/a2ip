module Test.Utils.Html.Encoding.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Encode.DecodeHtmlEntities as DecodeHtmlEntities
import Test.Utils.Html.Encode.EncodeHtmlEntities as EncodeHtmlEntities

spec :: Spec Unit
spec = do
  DecodeHtmlEntities.spec
  EncodeHtmlEntities.spec