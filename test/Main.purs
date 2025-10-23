module Test.Main where

import Proem

import Effect (Effect)
import Test.Spec.Reporter.Spec (specReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Util.Index as Util

main :: Effect Unit
main = runSpecAndExitProcess [specReporter] do
  Util.spec
