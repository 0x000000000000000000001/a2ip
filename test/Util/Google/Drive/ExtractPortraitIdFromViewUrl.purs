module Test.Util.Google.Drive.ExtractPortraitIdFromViewUrl where

import Proem

import Data.Maybe (Maybe(..))
import Test.Spec (Spec, it)
import Test.Util.Assert ((===))
import Test.Util.Describe (describe)
import Util.Google.Drive (extractPortraitIdFromViewUrl)

spec :: Spec Unit
spec = describe do

  it "extracts file ID from complete Google Drive view URL" do
    let url = "https://drive.google.com/file/d/1cZ8vLGx4n2Y_2aB5cD3eF1gH2iJ3kL4m/view"
    let result = extractPortraitIdFromViewUrl url
    result === Just "1cZ8vLGx4n2Y_2aB5cD3eF1gH2iJ3kL4m"

  it "extracts file ID from URL with additional parameters" do
    let url = "https://drive.google.com/file/d/1ABC123xyz789/view?usp=sharing"
    let result = extractPortraitIdFromViewUrl url
    result === Just "1ABC123xyz789"

  it "handles URL without /view suffix" do
    let url = "https://drive.google.com/file/d/1DEF456uvw012"
    let result = extractPortraitIdFromViewUrl url
    result === Just "1DEF456uvw012"

  it "handles URL without prefix but with /view suffix" do
    let url = "1GHI789rst345/view"
    let result = extractPortraitIdFromViewUrl url
    result === Just "1GHI789rst345"

  it "returns nothing when no patterns match" do
    let url = "https://example.com/some/other/url"
    let result = extractPortraitIdFromViewUrl url
    result === Nothing

  it "handles empty string and returns nothing" do
    let url = ""
    let result = extractPortraitIdFromViewUrl url
    result === Nothing

  it "handles malformed URL with prefix but no ID" do
    let url = "https://drive.google.com/file/d/"
    let result = extractPortraitIdFromViewUrl url
    result === Nothing

  it "extracts ID from URL with extra path segments" do
    let url = "https://drive.google.com/file/d/1JKL012mno678/view/something/else"
    let result = extractPortraitIdFromViewUrl url
    result === Just "1JKL012mno678"

  it "handles URL with only file ID (no prefix or suffix)" do
    let url = "1MNO345pqr901"
    let result = extractPortraitIdFromViewUrl url
    result === Just "1MNO345pqr901"

  it "returns Nothing for URL from different domain (https)" do
    let url = "https://example.com/file/d/1A2B3C4D5E6F7G8H9I0J/view"
    let result = extractPortraitIdFromViewUrl url
    result === Nothing

  it "returns Nothing for URL from different domain (http)" do
    let url = "http://example.com/file/d/1A2B3C4D5E6F7G8H9I0J/view"
    let result = extractPortraitIdFromViewUrl url
    result === Nothing