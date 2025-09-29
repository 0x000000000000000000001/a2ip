module Test.Main where

import Prelude

import Effect (Effect)
import Test.Spec.Reporter.Spec (specReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Component.Index as Component
import Test.Utils.Index as Utils  

main :: Effect Unit
main = runSpecAndExitProcess [specReporter] do
  Component.spec
  Utils.spec
