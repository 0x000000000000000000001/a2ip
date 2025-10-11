module Test.Component.Page.About.HandleAction where

import Proem

import Test.Spec (Spec)
import Test.Util.Describe (describe)

import Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTableHtml as ExtractMappingKeysAndValuesFromTableHtml
import Test.Component.Page.About.HandleAction.ConvertExtractedDataToMembers as ConvertExtractedDataToMembers

spec :: Spec Unit
spec = describe do
  ExtractMappingKeysAndValuesFromTableHtml.spec
  ConvertExtractedDataToMembers.spec 