module Test.Util.Html.Table.ExtractInnerCellsFromHtml where

import Proem

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Html.Table (extractInnerCellsFromHtml)

spec :: Spec Unit
spec = describe do

  it "extracts cells from simple table" do
    let html = """<html><body><table><tr><td>1</td><td>2</td></tr><tr><td>3</td><td>4</td></tr></table></body></html>"""
    extractInnerCellsFromHtml html === Just [["1", "2"], ["3", "4"]]

  it "extracts cells from table with mixed th and td" do
    let html = """<table><tr><th>Header 1</th><th>Header 2</th></tr><tr><td>Data 1</td><td>Data 2</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["Header 1", "Header 2"], ["Data 1", "Data 2"]]

  it "extracts cells with complex HTML content" do
    let html = """<table><tr><td><strong>Bold</strong></td><td><em>Italic</em></td></tr><tr><td><a href="link">Link</a></td><td>Plain text</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["<strong>Bold</strong>", "<em>Italic</em>"], ["<a href=\"link\">Link</a>", "Plain text"]]

  it "handles table with attributes" do
    let html = """<table class="data"><tr id="row1"><td class="cell">Value 1</td><td>Value 2</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["Value 1", "Value 2"]]

  it "handles empty cells" do
    let html = """<table><tr><td></td><td>Not empty</td></tr><tr><td>Content</td><td></td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["", "Not empty"], ["Content", ""]]

  it "returns Nothing when no table found" do
    let html = """<div><p>No table here</p></div>"""
    extractInnerCellsFromHtml html === Nothing

  it "returns Nothing for empty string" do
    extractInnerCellsFromHtml "" === Nothing

  it "handles table with no rows" do
    let html = """<table></table>"""
    extractInnerCellsFromHtml html === Nothing

  it "handles single row table" do
    let html = """<table><tr><td>Only cell</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["Only cell"]]

  it "handles single cell table" do
    let html = """<table><tr><td>Single</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["Single"]]

  it "handles rows with different number of cells" do
    let html = """<table><tr><td>1</td><td>2</td><td>3</td></tr><tr><td>A</td><td>B</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["1", "2", "3"], ["A", "B"]]

  it "handles malformed table (no closing table tag)" do
    let html = """<table><tr><td>Cell</td></tr>"""
    extractInnerCellsFromHtml html === Nothing

  it "handles table with special characters" do
    let html = """<table><tr><td>&amp; &lt; &gt;</td><td>"Quotes"</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["&amp; &lt; &gt;", "\"Quotes\""]]

  it "handles table with line breaks and spacing" do
    let html = """<table>
      <tr>
        <td>Cell 1</td>
        <td>Cell 2</td>
      </tr>
      <tr>
        <td>Cell 3</td>
        <td>Cell 4</td>
      </tr>
    </table>"""
    extractInnerCellsFromHtml html === Just [["Cell 1", "Cell 2"], ["Cell 3", "Cell 4"]]

  it "extracts from first table when multiple tables exist" do
    let html = """<table><tr><td>First table</td></tr></table><table><tr><td>Second table</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["First table"]]

  it "handles table with thead and tbody sections" do
    let html = """<table>
      <thead><tr><th>Name</th><th>Age</th></tr></thead>
      <tbody><tr><td>John</td><td>25</td></tr><tr><td>Jane</td><td>30</td></tr></tbody>
    </table>"""
    extractInnerCellsFromHtml html === Just [["Name", "Age"], ["John", "25"], ["Jane", "30"]]

  it "handles self-closing tags in cells" do
    let html = """<table><tr><td>Image: <img src="test.jpg"/></td><td><br/>Break</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["Image: <img src=\"test.jpg\"/>", "<br/>Break"]]

  it "handles cells with attributes containing quotes" do
    let html = """<table><tr><td title="Cell with 'quotes'">Content</td><td data-value="123">Data</td></tr></table>"""
    extractInnerCellsFromHtml html === Just [["Content", "Data"]]

  it "handles large table with many rows" do
    let html = """<table>
      <tr><td>R1C1</td><td>R1C2</td></tr>
      <tr><td>R2C1</td><td>R2C2</td></tr>
      <tr><td>R3C1</td><td>R3C2</td></tr>
      <tr><td>R4C1</td><td>R4C2</td></tr>
    </table>"""
    extractInnerCellsFromHtml html === Just [["R1C1", "R1C2"], ["R2C1", "R2C2"], ["R3C1", "R3C2"], ["R4C1", "R4C2"]]