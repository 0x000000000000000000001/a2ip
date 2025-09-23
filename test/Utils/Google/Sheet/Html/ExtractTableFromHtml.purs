module Test.Utils.Google.Sheet.Html.ExtractTableFromHtml where

import Prelude

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Bdd.Describe.Here (here) 
import Utils.Google.Sheet.Html (extractTableFromHtml)
 
spec :: Spec Unit
spec = here do  

  it "extracts table from complete HTML" do
    let
      htmlWithTable =
        """<html>
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
</html>"""

    extractTableFromHtml htmlWithTable === Just
      """<table class="some-class" id="data-table">
        <tr>
            <th>Header 1</th>
            <th>Header 2</th>
        </tr>
        <tr>
            <td>Data 1</td>
            <td>Data 2</td>
        </tr>
    </table>"""

  it "returns nothing when no table found" do
    let
      htmlWithoutTable =
        """
      <html>
        <head><title>Test</title></head>
        <body>
          <div>Some content</div>
          <p>No table here</p>
        </body>
      </html>
    """

    extractTableFromHtml htmlWithoutTable === Nothing

  it "returns nothing when incomplete table (no closing tag)" do
    let htmlIncompleteTable = "before<table>content"
    extractTableFromHtml htmlIncompleteTable === Nothing

  it "extracts first table when multiple tables exist" do
    let htmlMultipleTables = "prefix<table>content 1</table>infix<table>content 2</table>suffix"
    extractTableFromHtml htmlMultipleTables === Just "<table>content 1</table>"

  it "handles empty string" do
    extractTableFromHtml "" === Nothing

  it "handles complex table with attributes and nested elements" do
    let
      htmlComplexTable =
        """
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

    extractTableFromHtml htmlComplexTable === Just
      """<table class="data-table" style="width: 100%" data-test="value">
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
        </table>"""