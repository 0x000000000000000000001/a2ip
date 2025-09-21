module Test.Main where

import Prelude

import Effect (Effect)
import Test.Spec.Reporter.Spec (specReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Utils.Google.Sheet.Html as UtilsGoogleSheetHtml

main :: Effect Unit
main = runSpecAndExitProcess [specReporter] do
  UtilsGoogleSheetHtml.spec
