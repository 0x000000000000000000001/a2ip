module Test.Component.Page.About.HandleAction.Index where

import Prelude

import Test.Spec (Spec)

import Test.Component.Page.About.HandleAction.ExtractMappingKeysAndValuesFromTable as ExtractMappingKeysAndValuesFromTable

spec :: Spec Unit
spec = do
  ExtractMappingKeysAndValuesFromTable.spec