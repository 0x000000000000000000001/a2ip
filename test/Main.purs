module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Reporter.Spec (specReporter)
import Test.Spec.Runner (runSpec)
import Test.Utils.Google.Sheet.Html as UtilsGoogleSheetHtml

main :: Effect Unit
main = launchAff_ $ runSpec [specReporter] do
  UtilsGoogleSheetHtml.spec
