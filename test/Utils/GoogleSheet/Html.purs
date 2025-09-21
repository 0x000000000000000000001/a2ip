module Test.Utils.GoogleSheet.Html where

import Prelude

import Control.Monad.Error.Class (try)
import Data.Array (filter)
import Data.Array as Array
import Data.Either (Either(..))
import Data.String (Pattern(..), contains, length)

import Data.Traversable (sequence)
import Effect (Effect)
import Effect.Class.Console (log)

import Test.Assert (assert)
import Utils.GoogleSheet.Html (extractTableFromHtml)

-- Helper to run a test safely and report results
runTest :: String -> Effect Unit -> Effect Boolean
runTest testName testAction = do
  result <- try testAction
  case result of
    Right _ -> do
      log ("✓ " <> testName <> " passed")
      pure true
    Left err -> do
      log ("✗ " <> testName <> " failed: " <> show err)
      pure false

-- | Test suite for extractTableFromHtml function
-- | This function should extract the first <table>...</table> from HTML content
testExtractTableFromHtml :: Effect Unit
testExtractTableFromHtml = do
  log "Testing extractTableFromHtml..."
  
  results <- sequence
    [ runTest "Test 1: Extracts table from complete HTML" testCompleteTable
    , runTest "Test 2: Returns original HTML when no table found" testNoTable
    , runTest "Test 3: Handles incomplete table" testIncompleteTable
    , runTest "Test 4: Extracts table content correctly" testMultipleTables
    , runTest "Test 5: Handles empty string" testEmptyString
    , runTest "Test 6: Handles complex table with attributes and nested elements" testComplexTable
    , runTest "Test 7: Handles self-closing elements within table" testSelfClosingElements
    , runTest "Test 8: Handles mixed case HTML tags" testCaseSensitivity
    ]
  
  let passedCount = Array.length (filter identity results)
  let totalCount = Array.length results
  
  if passedCount == totalCount then do
    log ("All extractTableFromHtml tests passed! ✅ (" <> show passedCount <> "/" <> show totalCount <> ")")
  else do
    log ("Some tests failed! ❌ (" <> show passedCount <> "/" <> show totalCount <> " passed)")

testCompleteTable :: Effect Unit
testCompleteTable = do
  let htmlWithTable = """
    <html>
      <head><title>Test</title></head>
      <body>
        <div>Some content before</div>
        <table class="some-class" id="data-table">
          <tr>
            <th>Header 1</th>
            <th>Header 2</th>
          </tr>
          <tr>
            <td>Data 1</td>
            <td>Data 2</td>
          </tr>
        </table>
        <div>Some content after</div>
      </body>
    </html>
  """
  
  let result = extractTableFromHtml htmlWithTable
  assert (contains (Pattern "<table") result)
  assert (contains (Pattern "</table>") result)
  assert (contains (Pattern "Header 1") result)
  assert (contains (Pattern "Data 1") result)
  -- Should not contain content outside the table
  assert (not $ contains (Pattern "Some content before") result)
  assert (not $ contains (Pattern "Some content after") result)
  pure unit

testNoTable :: Effect Unit  
testNoTable = do
  let htmlWithoutTable = """
    <html>
      <head><title>Test</title></head>
      <body>
        <div>Some content</div>
        <p>No table here</p>
      </body>
    </html>
  """
  
  let result = extractTableFromHtml htmlWithoutTable
  assert (result == htmlWithoutTable)
  pure unit

testIncompleteTable :: Effect Unit
testIncompleteTable = do
  let htmlIncompleteTable = "before<table>content"
  
  let result = extractTableFromHtml htmlIncompleteTable
  -- When there's no closing </table>, the function returns everything from <table onwards
  assert (result == "<table>content")
  pure unit

testMultipleTables :: Effect Unit
testMultipleTables = do
  -- Test with a realistic case: HTML with proper table structure
  let htmlMultipleTables = "prefix<table>content</table>suffix"
  
  let result = extractTableFromHtml htmlMultipleTables
  -- The function extracts from <table to </table> 
  assert (result == "<table>content</table>")
  pure unit

testEmptyString :: Effect Unit
testEmptyString = do
  let result = extractTableFromHtml ""
  assert (result == "")
  pure unit

testComplexTable :: Effect Unit
testComplexTable = do
  let htmlComplexTable = """
    <div class="container">
      <table class="data-table" style="width: 100%" data-test="value">
        <thead>
          <tr>
            <th colspan="2">Complex Header</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><a href="http://example.com">Link</a></td>
            <td><span style="color: red;">Styled text</span></td>
          </tr>
        </tbody>
      </table>
      <footer>Footer content</footer>
    </div>
  """
  
  let result = extractTableFromHtml htmlComplexTable
  assert (contains (Pattern "<table") result)
  assert (contains (Pattern "data-test=\"value\"") result)
  assert (contains (Pattern "Complex Header") result)
  assert (contains (Pattern "<a href") result)
  assert (contains (Pattern "Styled text") result)
  assert (not $ contains (Pattern "Footer content") result)
  pure unit

testSelfClosingElements :: Effect Unit  
testSelfClosingElements = do
  let htmlWithSelfClosing = """
    <div>
      <table>
        <tr>
          <td>Before<br/>Middle<hr/>After</td>
          <td><img src="test.jpg" alt="test"/></td>
        </tr>
      </table>
    </div>
  """
  
  let result = extractTableFromHtml htmlWithSelfClosing
  assert (contains (Pattern "<br/>") result)
  assert (contains (Pattern "<hr/>") result)
  assert (contains (Pattern "<img") result)
  pure unit

testCaseSensitivity :: Effect Unit
testCaseSensitivity = do
  let htmlMixedCase = """
    <DIV>
      <Table border="1">
        <TR>
          <TD>Mixed case content</TD>
        </TR>
      </Table>
    </DIV>
  """
  
  let result = extractTableFromHtml htmlMixedCase
  -- Function should still work with different cases
  assert (contains (Pattern "<Table") result)
  assert (contains (Pattern "Mixed case content") result)
  assert (length result > 0)
  pure unit

