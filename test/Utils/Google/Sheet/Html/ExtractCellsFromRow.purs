module Test.Utils.Google.Sheet.Html.ExtractCellsFromRow where

import Prelude

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Describe (describe)
import Utils.Google.Sheet.Html (extractCellsFromRow)
  
spec :: Spec Unit
spec = describe do

  it "extracts cells from a simple row" do
    let rowHtml1 = """<tr>
      <td>Cell 1</td>
      <td>Cell 2</td>
      <td>Cell 3</td>
    </tr>"""
    
    extractCellsFromRow rowHtml1 === Just ["Cell 1", "Cell 2", "Cell 3"]

    let rowHtml2 = """
      <td>Cell 1</td>
      <td>Cell 2</td>
      <td>Cell 3</td>
    """
    
    extractCellsFromRow rowHtml2 === Just ["Cell 1", "Cell 2", "Cell 3"]

  it "extracts cells from row with different cell types" do
    let rowHtml = """<tr>
      <th>Header</th>
      <td>Data 1</td>
      <td>Data 2</td>
    </tr>"""
    
    extractCellsFromRow rowHtml === Just ["Header", "Data 1", "Data 2"]

  it "handles empty cells" do
    let rowHtml = """<tr>
      <td>First</td>
      <td></td>
      <td>Third</td>
    </tr>"""
    
    extractCellsFromRow rowHtml === Just ["First", "", "Third"]

  it "extracts cells with attributes and classes" do
    let rowHtml = """<tr>
      <td class="cell-class" id="cell-1">Content 1</td>
      <td style="color: red;">Content 2</td>
      <td colspan="2">Spanning cell</td>
    </tr>"""
    
    extractCellsFromRow rowHtml === Just ["Content 1", "Content 2", "Spanning cell"]

  it "handles nested HTML in cells" do
    let rowHtml = """<tr>
      <td><strong>Bold text</strong></td>
      <td><a href="#">Link text</a></td>
      <td><span>Span text</span></td>
    </tr>"""
    
    extractCellsFromRow rowHtml === Just ["<strong>Bold text</strong>", "<a href=\"#\">Link text</a>", "<span>Span text</span>"]

  it "returns Nothing for invalid HTML" do
    let invalidHtml = """<div>Not a table row</div>"""
    
    extractCellsFromRow invalidHtml === Nothing

  it "returns Nothing for empty string" do
    extractCellsFromRow "" === Nothing

  it "returns empty array for row with no cells" do
    let emptyRow = """<tr></tr>"""
    
    extractCellsFromRow emptyRow === Just []