module Test.Utils.Html.Encoding.Index where

import Prelude

import Test.Spec (Spec)
import Test.Utils.Html.Encoding.DecodeHtmlEntities as DecodeHtmlEntities
import Test.Utils.Html.Encoding.EncodeHtmlEntities as EncodeHtmlEntities

spec :: Spec Unit
spec = do
  DecodeHtmlEntities.spec
  EncodeHtmlEntities.spec