module Bin.HelloWorld.Main (main) where

import Prelude

import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  log "Hello World from PureScript! 🚀"
 