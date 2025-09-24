module Test.Utils.Spec 
  ( it
  , module Test.Spec
  ) where

import Prelude

import Effect.Aff (Aff)
import Test.Spec (Spec, SpecT)
import Test.Spec as TestSpec

-- FFI function to get incremental test number
foreign import getItCallLine :: Unit -> Int

-- Enhanced `it` function that automatically adds line number to test name
it :: String -> Aff Unit -> Spec Unit  
it description test = do
  let lineNumber = getItCallLine unit
  let enhancedDescription = description <> " (line:" <> show lineNumber <> ")"
  TestSpec.it enhancedDescription test