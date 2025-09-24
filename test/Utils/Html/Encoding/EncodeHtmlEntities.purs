module Test.Utils.Html.Encoding.EncodeHtmlEntities where

import Prelude

import Test.Utils.Assert ((===))
import Test.Utils.Bdd.Describe.Here (here)
import Test.Utils.Spec (Spec, it)
import Utils.Html.Encoding (encodeHtmlEntities)

spec :: Spec Unit
spec = here do

  it "encodes HTML entities" do
    encodeHtmlEntities "<div>" === "&#x3C;div&#x3E;"
    encodeHtmlEntities "Hello & world" === "Hello &#x26; world"
    encodeHtmlEntities "\"quoted text\"" === "&#x22;quoted text&#x22;"

  it "handles empty strings" do
    encodeHtmlEntities "" === ""