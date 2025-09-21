module Test.Utils.Google.Sheet.Html.ExtractTableFromHtml where

import Prelude

import Data.String (Pattern(..), contains, length)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual, shouldSatisfy)
import Utils.Google.Sheet.Html (extractTableFromHtml)

-- | Test suite for extractTableFromHtml function
spec :: Spec Unit
spec = describe "extractTableFromHtml" do
  
  it "extracts table from complete HTML" do
    let htmlWithTable = """
      <html>
        <head><title>Test</title></head>
        <body>
          <div>Some content before</div>
          <table class="some-class" id="data-table">
            <tr>
              <th>Header 1</th>
              <th>Header 2</th>
            </tr>
            <tr>
              <td>Data 1</td>
              <td>Data 2</td>
            </tr>
          </table>
          <div>Some content after</div>
        </body>
      </html>
    """
    
    let result = extractTableFromHtml htmlWithTable
    result `shouldSatisfy` contains (Pattern "<table")
    result `shouldSatisfy` contains (Pattern "</table>")
    result `shouldSatisfy` contains (Pattern "Header 1")
    result `shouldSatisfy` contains (Pattern "Data 1")
    -- Should not contain content outside the table
    result `shouldSatisfy` (not <<< contains (Pattern "Some content before"))
    result `shouldSatisfy` (not <<< contains (Pattern "Some content after"))
  
  it "returns original HTML when no table found" do
    let htmlWithoutTable = """
      <html>
        <head><title>Test</title></head>
        <body>
          <div>Some content</div>
          <p>No table here</p>
        </body>
      </html>
    """
    
    let result = extractTableFromHtml htmlWithoutTable
    result `shouldEqual` htmlWithoutTable
  
  it "handles incomplete table (no closing tag)" do
    let htmlIncompleteTable = "before<table>content"
    let result = extractTableFromHtml htmlIncompleteTable
    result `shouldEqual` "<table>content"
  
  it "extracts first table when multiple tables exist" do
    let htmlMultipleTables = "prefix<table>content</table>suffix"
    let result = extractTableFromHtml htmlMultipleTables
    result `shouldEqual` "<table>content</table>"
  
  it "handles empty string" do
    let result = extractTableFromHtml ""
    result `shouldEqual` ""
  
  it "handles complex table with attributes and nested elements" do
    let htmlComplexTable = """
      <div class="container">
        <table class="data-table" style="width: 100%" data-test="value">
          <thead>
            <tr>
              <th colspan="2">Complex Header</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><a href="http://example.com">Link</a></td>
              <td><span style="color: red;">Styled text</span></td>
            </tr>
          </tbody>
        </table>
        <footer>Footer content</footer>
      </div>
    """
    
    let result = extractTableFromHtml htmlComplexTable
    result `shouldSatisfy` contains (Pattern "<table")
    result `shouldSatisfy` contains (Pattern "data-test=\"value\"")
    result `shouldSatisfy` contains (Pattern "Complex Header")
    result `shouldSatisfy` contains (Pattern "<a href")
    result `shouldSatisfy` contains (Pattern "Styled text")
    result `shouldSatisfy` (not <<< contains (Pattern "Footer content"))
  
  it "handles self-closing elements within table" do
    let htmlWithSelfClosing = """
      <div>
        <table>
          <tr>
            <td>Before<br/>Middle<hr/>After</td>
            <td><img src="test.jpg" alt="test"/></td>
          </tr>
        </table>
      </div>
    """
    
    let result = extractTableFromHtml htmlWithSelfClosing
    result `shouldSatisfy` contains (Pattern "<br/>")
    result `shouldSatisfy` contains (Pattern "<hr/>")
    result `shouldSatisfy` contains (Pattern "<img")
  
  it "handles mixed case HTML tags" do
    let htmlMixedCase = """
      <DIV>
        <Table border="1">
          <TR>
            <TD>Mixed case content</TD>
          </TR>
        </Table>
      </DIV>
    """
    
    let result = extractTableFromHtml htmlMixedCase
    result `shouldSatisfy` contains (Pattern "<Table")
    result `shouldSatisfy` contains (Pattern "Mixed case content")
    length result `shouldSatisfy` (_ > 0)