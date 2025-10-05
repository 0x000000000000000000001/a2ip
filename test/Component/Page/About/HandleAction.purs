module Test.Component.Page.About.HandleAction where

import Prelude

import Test.Spec (Spec)
import Test.Util.Describe (describe)

import Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTable as ExtractMappingKeysAndValuesFromTable
import Test.Component.Page.About.HandleAction.ConvertExtractedDataToMembers as ConvertExtractedDataToMembers

spec :: Spec Unit
spec = describe do
  ExtractMappingKeysAndValuesFromTable.spec
  ConvertExtractedDataToMembers.spec 