module Test.Component.Page.About.HandleAction.Index where

import Proem

import Test.Spec (Spec)

import Test.Component.Page.About.HandleAction.ConvertExtractedData as ConvertExtractedData
import Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTableHtml as ExtractMappingKeysAndValuesFromTableHtml

spec :: Spec Unit
spec = do
  ConvertExtractedData.spec
  ExtractMappingKeysAndValuesFromTableHtml.spec