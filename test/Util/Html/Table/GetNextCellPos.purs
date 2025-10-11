module Test.Util.Html.Table.GetNextCellPos where

import Proem

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Html.Table (getNextCellPos)

spec :: Spec Unit
spec = describe do

  it "finds td tag at the beginning" do
    let html = """<td>Content</td>"""
    getNextCellPos "td" html 0 false === Just 0
    getNextCellPos "td" html 0 true === Just 0

  it "finds th tag at the beginning" do
    let html = """<th>Header</th>"""
    getNextCellPos "th" html 0 false === Just 0
    getNextCellPos "th" html 0 true === Just 0

  it "finds td tag in the middle of HTML" do
    let html = """<tr><td>Content</td></tr>"""
    getNextCellPos "td" html 0 false === Just 4
    getNextCellPos "td" html 0 true === Just 4

  it "finds tag starting from specific offset" do
    let html = """<td>First</td><td>Second</td>"""
    getNextCellPos "td" html 5 false === Just 14
    getNextCellPos "td" html 5 true === Just 9
    getNextCellPos "td" html 16 false === Nothing
    getNextCellPos "td" html 16 true === Nothing

  it "finds first occurrence when multiple tags exist" do
    let html = """<td>First</td><td>Second</td><td>Third</td>"""
    getNextCellPos "td" html 0 false === Just 0
    getNextCellPos "td" html 0 true === Just 0

  it "returns Nothing when tag not found" do
    let html = """<tr><th>Header</th></tr>"""
    getNextCellPos "td" html 0 false === Nothing
    getNextCellPos "td" html 0 true === Nothing

  it "returns Nothing when offset is beyond HTML length" do
    let html = """<td>Content</td>"""
    getNextCellPos "td" html 100 false === Nothing
    getNextCellPos "td" html 100 true === Nothing

  it "finds tag after skipping first occurrence" do
    let html = """<td>First</td><td>Second</td>"""
    getNextCellPos "td" html 1 false === Just 14
    getNextCellPos "td" html 1 true === Just 13

  it "handles empty HTML string" do
    let html = ""
    getNextCellPos "td" html 0 false === Nothing
    getNextCellPos "td" html 0 true === Nothing

  it "finds tag with attributes" do
    let html = """<tr><td class="test">Content</td></tr>"""
    getNextCellPos "td" html 0 false === Just 4
    getNextCellPos "td" html 0 true === Just 4

  it "distinguishes between td and th tags" do
    let html = """<th>Header</th><td>Data</td>"""
    getNextCellPos "td" html 0 false === Just 15
    getNextCellPos "td" html 0 true === Just 15

  it "handles nested tags correctly" do
    let html = """<div><table><tr><td>Content</td></tr></table></div>"""
    getNextCellPos "td" html 0 false === Just 16
    getNextCellPos "td" html 0 true === Just 16

  it "handles any alien prefix" do
    let html = """prefix<td>Content</td>suffix"""
    getNextCellPos "td" html 6 false === Just 6
    getNextCellPos "td" html 6 true === Just 0

  it "handles case when tag appears in content" do
    let html = """<td>This contains <td> in text</td>"""
    getNextCellPos "td" html 0 false === Just 0
    getNextCellPos "td" html 0 true === Just 0
    getNextCellPos "td" html 1 false === Just 18
    getNextCellPos "td" html 1 true === Just 17

  it "finds tag case-sensitively" do
    let html = """<TD>Content</TD>"""
    getNextCellPos "td" html 0 false === Nothing
    getNextCellPos "td" html 0 true === Nothing