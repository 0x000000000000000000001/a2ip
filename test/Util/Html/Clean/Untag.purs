module Test.Util.Html.Clean.Untag where

import Proem

import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Html.Clean (untag)

spec :: Spec Unit
spec = describe do

  it "removes simple HTML tags" do
    let html = "<div>Hello World!</div>"
    untag html === "Hello World!"

  it "removes nested HTML tags" do
    let html = "<div>Hello <strong>World</strong>!</div>"
    untag html === "Hello World!"

  it "removes tags with attributes" do
    let html = "<p class=\"text\">This is a <a href=\"#\">link</a>.</p>"
    untag html === "This is a link."

  it "handles self-closing tags" do
    let html = "<div>Line 1<br/>Line 2</div>"
    untag html === "Line 1Line 2"

  it "handles empty tags" do
    let html = "<div></div>"
    untag html === ""

  it "handles text without tags" do
    let html = "Plain text without any tags"
    untag html === "Plain text without any tags"

  it "removes multiple nested levels" do
    let html = "<div><p><span><strong>Nested</strong></span></p></div>"
    untag html === "Nested"

  it "preserves spaces between tags" do
    let html = "<p>Word1</p> <p>Word2</p>"
    untag html === "Word1 Word2"

  it "handles tags with multiple attributes" do
    let html = "<a href=\"#\" class=\"link\" data-id=\"123\">Click here</a>"
    untag html === "Click here"

  it "removes tags with newlines" do
    let html = "<div\n  class=\"test\"\n>Content</div>"
    untag html === "Content"

  it "handles consecutive tags" do
    let html = "<strong><em>Bold and italic</em></strong>"
    untag html === "Bold and italic"

  it "preserves special characters in text" do
    let html = "<div>Special chars: &amp; &lt; &gt; &quot;</div>"
    untag html === "Special chars: &amp; &lt; &gt; &quot;"

  it "handles mixed content" do
    let html = "Before<div>Inside</div>After"
    untag html === "BeforeInsideAfter"

  it "handles unclosed tags gracefully" do
    let html = "<div>Content without closing tag"
    untag html === "Content without closing tag"

  it "handles unmatched closing tag" do
    let html = "Content</div>"
    untag html === "Content"

  it "handles empty string" do
    let html = ""
    untag html === ""

  it "handles string with only tags" do
    let html = "<div><span></span></div>"
    untag html === ""

  it "handles multiple spaces" do
    let html = "<p>Word1   Word2</p>"
    untag html === "Word1   Word2"

  it "preserves unicode characters" do
    let html = "<div>Hello 世界 🌍</div>"
    untag html === "Hello 世界 🌍"
