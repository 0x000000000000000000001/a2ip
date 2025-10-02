module Test.Utils.Html.Table.ExtractInnerRowsFromHtml where

import Prelude

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Describe (describe)
import Utils.Html.Table (extractInnerRowsFromHtml)

spec :: Spec Unit
spec = describe do

  it "extracts rows from simple table" do
    let tableHtml = """<table><tr><td>1</td><td>2</td></tr><tr><td>3</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>1</td><td>2</td>", "<td>3</td>"]

  it "extracts rows with complex content" do
    let tableHtml = """<table><tr><td>Cell <strong>1</strong></td><td>Cell 2</td></tr><tr><td>Cell 3</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Cell <strong>1</strong></td><td>Cell 2</td>", "<td>Cell 3</td>"]

  it "handles table with attributes" do
    let tableHtml = """<table class="data"><tr id="row1"><td>Value 1</td></tr><tr id="row2"><td>Value 2</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Value 1</td>", "<td>Value 2</td>"]

  it "handles empty table (no rows)" do
    let tableHtml = """<table></table>"""
    extractInnerRowsFromHtml tableHtml === Nothing

  it "handles table with only headers" do
    let tableHtml = """<table><thead><tr><th>Header 1</th><th>Header 2</th></tr></thead></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<th>Header 1</th><th>Header 2</th>"]

  it "handles table with mixed th and td" do
    let tableHtml = """<table><tr><th>Header</th><td>Data</td></tr><tr><td>More</td><td>Data</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<th>Header</th><td>Data</td>", "<td>More</td><td>Data</td>"]

  it "returns Nothing for HTML without table rows" do
    let html = """<div><p>No table here</p></div>"""
    extractInnerRowsFromHtml html === Nothing

  it "returns Nothing for empty string" do
    extractInnerRowsFromHtml "" === Nothing

  it "handles malformed table rows" do
    let tableHtml = """<table><tr><td>Complete row</td></tr><tr><td>Incomplete row"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Complete row</td>"]

  it "handles rows with nested tables" do
    let tableHtml = """<table><tr><td>Outer <table><tr><td>Inner</td></tr></table></td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Inner</td>"]

  it "handles rows with special characters" do
    let tableHtml = """<table><tr><td>Special &amp; chars</td><td>&lt;test&gt;</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Special &amp; chars</td><td>&lt;test&gt;</td>"]

  it "handles multiple consecutive spaces in rows" do
    let tableHtml = """<table><tr>   <td>Spaced</td>   <td>Content</td>   </tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Spaced</td>   <td>Content</td>"]

  it "handles self-closing tags in rows" do
    let tableHtml = """<table><tr><td>Image: <img src="test.jpg"/></td><td>Text</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Image: <img src=\"test.jpg\"/></td><td>Text</td>"]

  it "handles rows with line breaks" do
    let tableHtml = """<table>
      <tr>
        <td>Multi-line</td>
        <td>Content</td>
      </tr>
    </table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Multi-line</td>\n        <td>Content</td>"]

  it "handles single row table" do
    let tableHtml = """<table><tr><td>Only row</td></tr></table>"""
    extractInnerRowsFromHtml tableHtml === Just ["<td>Only row</td>"]