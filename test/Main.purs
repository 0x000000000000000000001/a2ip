module Test.Main where

import Prelude

import Effect (Effect)
import Test.Spec.Reporter.Spec (specReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Utils.Index as Utils  

main :: Effect Unit
main = runSpecAndExitProcess [specReporter] do
  Utils.spec
