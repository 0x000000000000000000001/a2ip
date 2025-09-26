module Test.Utils.Google.Sheet.Html.ExtractTableRows where

import Prelude

import Data.Array as Array
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Describe (describe)
import Utils.Google.Sheet.Html (extractRowsFromHtml)

spec :: Spec Unit
spec = describe do

  it "extracts rows from simple table HTML" do
    let tableHtml = """<table>
<tr>
  <th>Header 1</th>
  <th>Header 2</th>
</tr>
<tr>
  <td>Data 1</td>
  <td>Data 2</td>
</tr>
</table>"""
    let result = extractRowsFromHtml tableHtml
    let expected = 
          [ "<th>Header 1</th>\n  <th>Header 2</th>"
          , "<td>Data 1</td>\n  <td>Data 2</td>"
          ]
    result === expected

  it "handles table with no rows" do
    let tableHtml = "<table></table>"
    let result = extractRowsFromHtml tableHtml
    result === []

  it "handles table with nested elements in rows" do
    let tableHtml = """<table>
<tr>
  <td><a href="link">Link text</a></td>
  <td><span style="color:red">Styled text</span></td>
</tr>
<tr>
  <td><strong>Bold text</strong></td>
  <td><em>Italic text</em></td>
</tr>
</table>"""
    let result = extractRowsFromHtml tableHtml
    Array.length result === 2

  it "handles empty string" do
    let tableHtml = ""
    let result = extractRowsFromHtml tableHtml
    result === []

  it "handles HTML without tr elements" do
    let tableHtml = "<table><tbody><td>No tr tags</td></tbody></table>"
    let result = extractRowsFromHtml tableHtml
    result === []

  it "handles table with thead and tbody sections" do
    let tableHtml = """<table>
<thead>
<tr>
  <th>Name</th>
  <th>Age</th>
</tr>
</thead>
<tbody>
<tr>
  <td>John</td>
  <td>25</td>
</tr>
<tr>
  <td>Jane</td>
  <td>30</td>
</tr>
</tbody>
</table>"""
    let result = extractRowsFromHtml tableHtml
    Array.length result === 3

  it "accepts malformed HTML" do
    let tableHtml = "<table><tr><td>Unclosed cell<tr><td>Another row</td></tr></table>"
    let result = extractRowsFromHtml tableHtml
    Array.length result === 1