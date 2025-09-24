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

-- Simple `it` function that just passes through the description
it :: String -> Aff Unit -> Spec Unit  
it description test = TestSpec.it (description) test