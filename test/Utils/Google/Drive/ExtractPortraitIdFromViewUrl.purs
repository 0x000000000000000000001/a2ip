module Test.Utils.Google.Drive.ExtractPortraitIdFromViewUrl where

import Prelude

import Test.Spec (Spec, it)
import Test.Utils.Assert ((===))
import Test.Utils.Bdd.Describe.Function.Here (here)
import Utils.GoogleDrive (extractPortraitIdFromViewUrl)

spec :: Spec Unit
spec = here do

  it "extracts file ID from complete Google Drive view URL" do
    let url = "https://drive.google.com/file/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/view"
    let result = extractPortraitIdFromViewUrl url
    result === "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"

  it "extracts file ID from URL with additional parameters" do
    let url = "https://drive.google.com/file/d/1ABC123xyz789/view?usp=sharing"
    let result = extractPortraitIdFromViewUrl url
    result === "1ABC123xyz789"

  it "handles URL without /view suffix" do
    let url = "https://drive.google.com/file/d/1DEF456uvw012"
    let result = extractPortraitIdFromViewUrl url
    result === "1DEF456uvw012"

  it "handles URL without prefix" do
    let url = "1GHI789rst345/view"
    let result = extractPortraitIdFromViewUrl url
    result === "1GHI789rst345"

  it "returns original string when no patterns match" do
    let url = "https://example.com/some/other/url"
    let result = extractPortraitIdFromViewUrl url
    result === "https://example.com/some/other/url"

  it "handles empty string" do
    let url = ""
    let result = extractPortraitIdFromViewUrl url
    result === ""

  it "handles malformed URL with prefix but no ID" do
    let url = "https://drive.google.com/file/d/"
    let result = extractPortraitIdFromViewUrl url
    result === ""

  it "extracts ID from URL with extra path segments" do
    let url = "https://drive.google.com/file/d/1JKL012mno678/view/something/else"
    let result = extractPortraitIdFromViewUrl url
    result === "1JKL012mno678"

  it "handles URL with only file ID (no prefix or suffix)" do
    let url = "1MNO345pqr901"
    let result = extractPortraitIdFromViewUrl url
    result === "1MNO345pqr901"

  it "extracts from real Google Drive portrait URL" do
    let url = "https://drive.google.com/file/d/1cZ8vLGx4n2Y_2aB5cD3eF1gH2iJ3kL4m/view"
    let result = extractPortraitIdFromViewUrl url
    result === "1cZ8vLGx4n2Y_2aB5cD3eF1gH2iJ3kL4m"