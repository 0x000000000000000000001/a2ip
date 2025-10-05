module Test.Util.Html.Table.ExtractInnerColumnCellsFromHtml where

import Prelude

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Html.Table (extractInnerColumnCellsFromHtml)

spec :: Spec Unit
spec = describe do
  
  it "extracts columns from a simple table" do
    let html = "<table><tr><td>1</td><td>2</td></tr><tr><td>3</td><td>4</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["1", "3"], ["2", "4"]]

  it "handles tables with different row lengths" do
    let html = "<table><tr><td>1</td><td>2</td><td>3</td></tr><tr><td>4</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["1", "4"], ["2"], ["3"]]

  it "handles empty cells" do
    let html = "<table><tr><td></td><td>2</td></tr><tr><td>3</td><td></td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["", "3"], ["2", ""]]

  it "handles tables with th elements" do
    let html = "<table><tr><th>Header1</th><th>Header2</th></tr><tr><td>1</td><td>2</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["Header1", "1"], ["Header2", "2"]]

  it "handles single column table" do
    let html = "<table><tr><td>1</td></tr><tr><td>2</td></tr><tr><td>3</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["1", "2", "3"]]

  it "handles single row table" do
    let html = "<table><tr><td>1</td><td>2</td><td>3</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["1"], ["2"], ["3"]]

  it "handles nested HTML in cells" do
    let html = "<table><tr><td><span>1</span></td><td>2</td></tr><tr><td>3</td><td><b>4</b></td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["<span>1</span>", "3"], ["2", "<b>4</b>"]]

  it "handles whitespace in cells" do
    let html = "<table><tr><td>  1  </td><td>2</td></tr><tr><td>3</td><td>  4  </td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["1", "3"], ["2", "4"]]

  it "handles table with attributes" do
    let html = "<table class=\"data\"><tr id=\"row1\"><td class=\"cell\">1</td><td>2</td></tr><tr><td>3</td><td>4</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["1", "3"], ["2", "4"]]

  it "returns Nothing for invalid table HTML" do
    let html = "<table><tr><td>1</td></tr>"
    extractInnerColumnCellsFromHtml html === Nothing

  it "returns Nothing for empty string" do
    extractInnerColumnCellsFromHtml "" === Nothing

  it "returns Nothing for HTML without table" do
    let html = "<div>No table here</div>"
    extractInnerColumnCellsFromHtml html === Nothing

  it "handles empty table" do
    let html = "<table></table>"
    extractInnerColumnCellsFromHtml html === Just []

  it "handles table with empty rows" do
    let html = "<table><tr></tr><tr></tr></table>"
    extractInnerColumnCellsFromHtml html === Just []

  it "handles irregular table (jagged array)" do
    let html = "<table><tr><td>A</td><td>B</td><td>C</td></tr><tr><td>D</td></tr><tr><td>E</td><td>F</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["A", "D", "E"], ["B", "F"], ["C"]]

  it "handles table with only headers" do
    let html = "<table><tr><th>H1</th><th>H2</th></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["H1"], ["H2"]]

  it "handles mixed th and td in same row" do
    let html = "<table><tr><th>Header</th><td>Data1</td></tr><tr><td>Data2</td><td>Data3</td></tr></table>"
    extractInnerColumnCellsFromHtml html === Just [["Header", "Data2"], ["Data1", "Data3"]]

  it "handles large table" do
    let html = "<table>" <>
               "<tr><td>1</td><td>2</td><td>3</td></tr>" <>
               "<tr><td>4</td><td>5</td><td>6</td></tr>" <>
               "<tr><td>7</td><td>8</td><td>9</td></tr>" <>
               "</table>"
    extractInnerColumnCellsFromHtml html === Just [
      ["1", "4", "7"],
      ["2", "5", "8"],
      ["3", "6", "9"]
    ]
