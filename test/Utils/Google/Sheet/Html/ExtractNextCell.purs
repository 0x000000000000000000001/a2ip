module Test.Utils.Google.Sheet.Html.ExtractNextCell where

import Prelude

-- import Data.Maybe (Maybe(..))
-- import Test.Spec (Spec, it, itOnly)
-- import Test.Utils.Assert ((===))
-- import Test.Utils.Describe (describe, describeOnly)
-- import Utils.Google.Sheet.Html (extractNextCell)

-- spec :: Spec Unit
-- spec = describe do

--   it "extracts a simple td cell" do
--     let html = """<tr><td>Content</td></tr>"""
--     extractNextCell "td" html 0 === Just { content: ">Content", nextPos: 18 }

--   it "extracts a simple th cell" do
--     let html = """<tr><th>Header</th></tr>"""
--     extractNextCell "th" html 0 === Just { content: ">Header", nextPos: 17 }

--   it "extracts cell with attributes" do
--     let html = """<tr><td class="test" id="cell1">Content with attributes</td></tr>"""
--     extractNextCell "td" html 0 === Just { content: " class=\"test\" id=\"cell1\">Content with attributes", nextPos: 58 }

--   it "extracts cell with nested HTML" do
--     let html = """<tr><td><strong>Bold</strong> text</td></tr>"""
--     extractNextCell "td" html 0 === Just { content: "><strong>Bold</strong> text", nextPos: 39 }

--   it "finds cell at specific position" do
--     let html = """<tr><td>First</td><td>Second</td></tr>"""
--     extractNextCell "td" html 14 === Just { content: ">Second", nextPos: 32 }

--   it "returns Nothing when tag not found" do
--     let html = """<tr><th>Header</th></tr>"""
--     extractNextCell "td" html 0 === Nothing

--   it "returns Nothing for malformed HTML (no closing tag)" do
--     let html = """<tr><td>Unclosed cell"""
--     extractNextCell "td" html 0 === Nothing

--   it "handles empty cell" do
--     let html = """<tr><td></td></tr>"""
--     extractNextCell "td" html 0 === Just { content: ">", nextPos: 13 }

--   it "extracts first occurrence when multiple cells exist" do
--     let html = """<tr><td>First</td><td>Second</td><td>Third</td></tr>"""
--     extractNextCell "td" html 0 === Just { content: ">First", nextPos: 14 }

--   it "handles mixed td and th tags" do
--     let html = """<tr><th>Header</th><td>Data</td></tr>"""
--     extractNextCell "td" html 0 === Just { content: ">Data", nextPos: 32 }

--   it "extracts cell starting from middle of HTML" do
--     let html = """<html><body><tr><td>Content</td></tr></body></html>"""
--     extractNextCell "td" html 12 === Just { content: ">Content", nextPos: 30 }

--   it "returns Nothing when starting position is beyond HTML length" do
--     let html = """<tr><td>Content</td></tr>"""
--     extractNextCell "td" html 100 === Nothing