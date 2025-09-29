module Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTable where

import Prelude

import Component.Page.About.HandleAction (extractMappingKeysAndValuesFromTable)
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Describe (describe)

spec :: Spec Unit
spec = describe do

  it "extracts keys and values from table with headers and data" do
    let html = """<table><tr><th>Name</th><th>Age</th><th>City</th></tr><tr><td>Alice</td><td>30</td><td>Paris</td></tr><tr><td>Bob</td><td>25</td><td>London</td></tr></table>"""
    let expected = { keys: ["Name", "Age", "City"], values: [["Alice", "30", "Paris"], ["Bob", "25", "London"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "extracts keys and values from table with mixed th and td in first row" do
    let html = """<table><tr><td>Header1</td><td>Header2</td></tr><tr><td>Data1</td><td>Data2</td></tr></table>"""
    let expected = { keys: ["Header1", "Header2"], values: [["Data1", "Data2"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with only header row (no data rows)" do
    let html = """<table><tr><th>Name</th><th>Age</th></tr></table>"""
    let expected = { keys: ["Name", "Age"], values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with single cell" do
    let html = """<table><tr><td>Only cell</td></tr></table>"""
    let expected = { keys: ["Only cell"], values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with different number of cells per row" do
    let html = """<table><tr><th>A</th><th>B</th><th>C</th></tr><tr><td>1</td><td>2</td></tr><tr><td>X</td><td>Y</td><td>Z</td><td>Extra</td></tr></table>"""
    let expected = { keys: ["A", "B", "C"], values: [["1", "2"], ["X", "Y", "Z", "Extra"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles empty cells in keys and values" do
    let html = """<table><tr><th></th><th>Name</th><th></th></tr><tr><td>1</td><td></td><td>Value</td></tr></table>"""
    let expected = { keys: ["", "Name", ""], values: [["1", "", "Value"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with complex HTML content in cells" do
    let html = """<table><tr><th><strong>Name</strong></th><th>Info</th></tr><tr><td><em>Alice</em></td><td><a href="link">Link</a></td></tr></table>"""
    let expected = { keys: ["<strong>Name</strong>", "Info"], values: [["<em>Alice</em>", "<a href=\"link\">Link</a>"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with attributes" do
    let html = """<table class="data"><tr id="header"><th class="name">Name</th><th>Age</th></tr><tr><td>John</td><td>35</td></tr></table>"""
    let expected = { keys: ["Name", "Age"], values: [["John", "35"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with line breaks and whitespace" do
    let html = """<table>
      <tr>
        <th>First Name</th>
        <th>Last Name</th>
      </tr>
      <tr>
        <td>Jane</td>
        <td>Doe</td>
      </tr>
    </table>"""
    let expected = { keys: ["First Name", "Last Name"], values: [["Jane", "Doe"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with special characters" do
    let html = """<table><tr><th>&amp; Symbols</th><th>"Quotes"</th></tr><tr><td>&lt;Data&gt;</td><td>'Value'</td></tr></table>"""
    let expected = { keys: ["&amp; Symbols", "\"Quotes\""], values: [["&lt;Data&gt;", "'Value'"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles multiple data rows" do
    let html = """<table>
      <tr><th>ID</th><th>Status</th></tr>
      <tr><td>001</td><td>Active</td></tr>
      <tr><td>002</td><td>Inactive</td></tr>
      <tr><td>003</td><td>Pending</td></tr>
      <tr><td>004</td><td>Active</td></tr>
    </table>"""
    let expected = { keys: ["ID", "Status"], values: [["001", "Active"], ["002", "Inactive"], ["003", "Pending"], ["004", "Active"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "returns empty structure when no table found" do
    let html = """<div><p>No table here</p></div>"""
    let expected = { keys: [], values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "returns empty structure for empty string" do
    let html = ""
    let expected = { keys: [], values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "returns empty structure for malformed HTML" do
    let html = """<table><tr><th>Header</th><tr><td>Data</td>"""
    let expected = { keys: [], values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with nested tables (extracts from outer table)" do
    let html = """<table><tr><th>Outer Header</th></tr><tr><td><table><tr><td>Inner</td></tr></table></td></tr></table>"""
    let expected = { keys: ["Outer Header"], values: [["Inner"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table within complex HTML document" do
    let html = """<html><body><div><table><tr><th>Product</th><th>Price</th></tr><tr><td>Widget</td><td>$10</td></tr></table></div></body></html>"""
    let expected = { keys: ["Product", "Price"], values: [["Widget", "$10"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with tbody and thead sections" do
    let html = """<table>
      <thead><tr><th>Department</th><th>Budget</th></tr></thead>
      <tbody>
        <tr><td>IT</td><td>50000</td></tr>
        <tr><td>HR</td><td>30000</td></tr>
      </tbody>
    </table>"""
    let expected = { keys: ["Department", "Budget"], values: [["IT", "50000"], ["HR", "30000"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "extracts from first table when multiple tables exist" do
    let html = """<table><tr><th>First</th></tr><tr><td>Data1</td></tr></table><table><tr><th>Second</th></tr><tr><td>Data2</td></tr></table>"""
    let expected = { keys: ["First"], values: [["Data1"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles large table with many columns and rows" do
    let html = """<table>
      <tr><th>Col1</th><th>Col2</th><th>Col3</th><th>Col4</th><th>Col5</th></tr>
      <tr><td>A1</td><td>A2</td><td>A3</td><td>A4</td><td>A5</td></tr>
      <tr><td>B1</td><td>B2</td><td>B3</td><td>B4</td><td>B5</td></tr>
      <tr><td>C1</td><td>C2</td><td>C3</td><td>C4</td><td>C5</td></tr>
    </table>"""
    let expected = { 
      keys: ["Col1", "Col2", "Col3", "Col4", "Col5"], 
      values: [
        ["A1", "A2", "A3", "A4", "A5"],
        ["B1", "B2", "B3", "B4", "B5"], 
        ["C1", "C2", "C3", "C4", "C5"]
      ]
    }
    extractMappingKeysAndValuesFromTable html === expected