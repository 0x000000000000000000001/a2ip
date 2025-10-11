module Test.Util.Html.Encode.EncodeHtmlEntities where

import Proem

import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Html.Encode (encodeHtmlEntities)

spec :: Spec Unit 
spec = describe do

  it "encodes HTML entities" do
    encodeHtmlEntities "<div>" === "&#x3C;div&#x3E;"
    encodeHtmlEntities "Hello & world" === "Hello &#x26; world"
    encodeHtmlEntities "\"quoted text\"" === "&#x22;quoted text&#x22;"

  it "handles empty strings" do
    encodeHtmlEntities "" === ""