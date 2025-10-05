module Test.Component.Page.About.HandleAction.Index where

import Prelude

import Test.Spec (Spec)

import Test.Component.Page.About.HandleAction.ConvertExtractedDataToMembers as ConvertExtractedDataToMembers
import Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTableHtml as ExtractMappingKeysAndValuesFromTableHtml

spec :: Spec Unit
spec = do
  ConvertExtractedDataToMembers.spec
  ExtractMappingKeysAndValuesFromTableHtml.spec