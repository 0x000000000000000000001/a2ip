module Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTable where

import Prelude

import Component.Page.About.HandleAction (extractMappingKeysAndValuesFromTable)
import Data.Array (mapWithIndex)
import Data.Map (Map, empty, fromFoldable)
import Data.Tuple (Tuple(..))
import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Describe (describe)

-- Helper function to create index map
arrayToIndexMap :: forall a. Ord a => Array a -> Map a Int
arrayToIndexMap arr = fromFoldable $ mapWithIndex (\i x -> Tuple x i) arr

spec :: Spec Unit
spec = describe do

  it "extracts keys and values from table with headers and data" do
    let html = """<table><tr><th>Name</th><th>Age</th></tr><tr><td>Alice</td><td>30</td></tr><tr><td>Bob</td><td>25</td></tr></table>"""
    let keys = ["Name", "Age"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [["Alice", "30"], ["Bob", "25"]] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles table with only header row (no data rows)" do
    let html = """<table><tr><th>Name</th><th>Age</th></tr></table>"""
    let keys = ["Name", "Age"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "returns empty structure when no table found" do
    let html = """<div><p>No table here</p></div>"""
    let expected = { keys: [], keyIndices: empty, values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "returns empty structure for empty string" do
    let html = ""
    let expected = { keys: [], keyIndices: empty, values: [] }
    extractMappingKeysAndValuesFromTable html === expected

  it "handles single cell table" do
    let html = """<table><tr><td>Only cell</td></tr></table>"""
    let keys = ["Only cell"]
    let expected = { keys, keyIndices: arrayToIndexMap keys, values: [] }
    extractMappingKeysAndValuesFromTable html === expected