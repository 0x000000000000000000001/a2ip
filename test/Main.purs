module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)
import Test.Utils.GoogleSheet.Html (testExtractTableFromHtml)

main :: Effect Unit
main = do
  log "🧪 Running tests..."
  log ""
  testExtractTableFromHtml
  log ""
  log "🎉 All tests completed!"
