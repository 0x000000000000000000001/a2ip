module Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTableHtml where

import Proem

import Component.Page.About.HandleAction (extractMappingKeysAndValuesFromTableHtml)
import Data.Map (empty)
import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe, describeOnly)
import Util.Array.Map (arrayToIndexMap)

spec :: Spec Unit
spec = describeOnly do

  it "extracts keys and values from table with headers and data" do
    let html = """<table><tr><th>Name</th><th>Age</th></tr><tr><td>Alice</td><td>30</td></tr><tr><td>Bob</td><td>25</td></tr></table>"""
    let keys = ["Name", "Age"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [["Alice", "30"], ["Bob", "25"]] }
    extractMappingKeysAndValuesFromTableHtml html === expected

  it "handles table with only header row (no data rows)" do
    let html = """<table><tr><th>Name</th><th>Age</th></tr></table>"""
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

  it "handles single cell table" do
    let html = """<table><tr><td>Only cell</td></tr></table>"""
    let keys = ["Only cell"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [] }
    extractMappingKeysAndValuesFromTableHtml html === expected