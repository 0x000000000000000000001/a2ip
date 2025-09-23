module Test.Utils.Google.Sheet.Html.ExtractTableRows where

import Prelude

import Data.Array as Array
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Bdd.Describe.Here (here)
import Utils.Google.Sheet.Html (extractTableRows)

spec :: Spec Unit
spec = here do

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
    let result = extractTableRows tableHtml
    let expected = 
          [ "<table>\n"
          , ">\n  <th>Header 1</th>\n  <th>Header 2</th>\n</tr>\n"
          , ">\n  <td>Data 1</td>\n  <td>Data 2</td>\n</tr>\n</table>"
          ]
    result === expected

  it "handles table with no rows" do
    let tableHtml = "<table></table>"
    let result = extractTableRows tableHtml
    result === ["<table></table>"]

  it "extracts multiple rows from complex table" do
    let tableHtml = """<table class="data-table">
<tr class="header">
  <th colspan="2">Complex Header</th>
</tr>
<tr id="row1">
  <td>Cell 1</td>
  <td>Cell 2</td>
</tr>
<tr id="row2">
  <td>Cell 3</td>
  <td>Cell 4</td>
</tr>
<tr id="row3">
  <td>Cell 5</td>
  <td>Cell 6</td>
</tr>
</table>"""
    let result = extractTableRows tableHtml
    -- Should split on each "<tr" occurrence
    Array.length result === 5 -- 1 initial part + 4 tr elements

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
    let result = extractTableRows tableHtml
    Array.length result === 3 -- 1 initial part + 2 tr elements

  it "handles empty string" do
    let tableHtml = ""
    let result = extractTableRows tableHtml
    result === [""]

  it "handles HTML without tr elements" do
    let tableHtml = "<table><tbody><td>No tr tags</td></tbody></table>"
    let result = extractTableRows tableHtml
    result === ["<table><tbody><td>No tr tags</td></tbody></table>"]

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
    let result = extractTableRows tableHtml
    Array.length result === 4 -- 1 initial + 3 tr elements

  it "preserves row attributes and content structure" do
    let tableHtml = """<table><tr class="first" id="header"><th>Header</th></tr><tr data-id="1"><td>Data</td></tr></table>"""
    let result = extractTableRows tableHtml
    let expected = 
          [ "<table>"
          , " class=\"first\" id=\"header\"><th>Header</th></tr>"
          , " data-id=\"1\"><td>Data</td></tr></table>"
          ]
    result === expected

  it "handles malformed HTML gracefully" do
    let tableHtml = "<table><tr><td>Unclosed cell<tr><td>Another row</td></tr></table>"
    let result = extractTableRows tableHtml
    Array.length result === 3 -- Should still split on "<tr" patterns