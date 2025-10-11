module Test.Util.Html.Encode.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Html.Encode.DecodeHtmlEntities as DecodeHtmlEntities
import Test.Util.Html.Encode.EncodeHtmlEntities as EncodeHtmlEntities

spec :: Spec Unit
spec = do
  DecodeHtmlEntities.spec
  EncodeHtmlEntities.spec