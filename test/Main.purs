module Test.Main where

import Prelude

import Effect (Effect)
import Test.Spec.Reporter.Spec (specReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Component.Index as Component
import Test.Util.Index as Util

main :: Effect Unit
main = runSpecAndExitProcess [specReporter] do
  Component.spec
  Util.spec
