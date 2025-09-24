module Test.Utils.Html.Encoding.DecodeHtmlEntities where

import Prelude

import Test.Utils.Assert ((===)) 
import Test.Utils.Bdd.Describe.Here (here)
import Test.Utils.Spec (Spec, it)
import Utils.Html.Encoding (decodeHtmlEntities)

spec :: Spec Unit
spec = here do

  it "decodes common HTML entities" do
    decodeHtmlEntities "&lt;div&gt;" === "<div>"
    decodeHtmlEntities "&amp;" === "&"
    decodeHtmlEntities "&quot;hello&quot;" === "\"hello\""
    decodeHtmlEntities "&#39;world&#39;" === "'world'"
    decodeHtmlEntities "&nbsp;" === "?"

  it "decodes complex HTML with multiple entities" do
    let input = "&lt;p class=&quot;text&quot;&gt;Hello &amp; world&lt;/p&gt;"
    let expected = "<p class=\"text\">Hello & world</p>"
    decodeHtmlEntities input === expected

  it "decodes numeric character references" do
    decodeHtmlEntities "&#60;div&#62;" === "<div>"
    decodeHtmlEntities "&#x3C;div&s#x3E;" === "<div>"
    decodeHtmlEntities "&#233;" === "é"

  it "handles strings without entities" do
    decodeHtmlEntities "Hello world" === "Hello world"
    decodeHtmlEntities "<div>No entities here</div>" === "<div>No entities here</div>"

  it "handles empty strings" do
    decodeHtmlEntities "" === ""