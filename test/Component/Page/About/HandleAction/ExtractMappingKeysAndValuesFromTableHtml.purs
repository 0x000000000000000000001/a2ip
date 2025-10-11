module Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTableHtml where

import Proem

import Component.Page.About.HandleAction (extractMappingKeysAndValuesFromTableHtml)
import Data.Map (empty)
import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Array.Map (arrayToIndexMap)

spec :: Spec Unit
spec = describe do

  it "extracts keys from index 1 and values from index 3 onwards" do
    let html = """<table><tr><th>Header0</th></tr><tr><th>Name</th><th>Age</th></tr><tr><td>Separator</td></tr><tr><td>Alice</td><td>30</td></tr><tr><td>Bob</td><td>25</td></tr></table>"""
    let keys = ["Name", "Age"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [["Alice", "30"], ["Bob", "25"]] }
    extractMappingKeysAndValuesFromTableHtml html === expected

  it "handles table with keys at index 1 but no data after index 3" do
    let html = """<table><tr><th>Row0</th></tr><tr><th>Name</th><th>Age</th></tr><tr><td>Row2</td></tr></table>"""
    let keys = ["Name", "Age"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [] }
    extractMappingKeysAndValuesFromTableHtml html === expected

  it "returns empty structure when no table found" do
    let html = """<div><p>No table here</p></div>"""
    let expected = { keys: [], keyIndices: empty, values: [] }
    extractMappingKeysAndValuesFromTableHtml html === expected

  it "returns empty structure for empty string" do
    let html = ""
    let expected = { keys: [], keyIndices: empty, values: [] }
    extractMappingKeysAndValuesFromTableHtml html === expected

  it "returns empty structure when table has less than 2 rows" do
    let html = """<table><tr><td>Only one row</td></tr></table>"""
    let expected = { keys: [], keyIndices: empty, values: [] }
    extractMappingKeysAndValuesFromTableHtml html === expected