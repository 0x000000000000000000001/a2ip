module Test.Util.Google.Sheet.Index where

import Proem

import Test.Spec (Spec)
import Test.Util.Google.Sheet.ConvertExtractedData as ConvertExtractedData
import Test.Util.Google.Sheet.ExtractMappingKeysAndValuesFromTableHtml as ExtractMappingKeysAndValuesFromTableHtml

spec :: Spec Unit
spec = do
  ConvertExtractedData.spec
  ExtractMappingKeysAndValuesFromTableHtml.spec