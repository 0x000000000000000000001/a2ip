module Test.Utils.Assert ((===), shouldEqual) where

import Prelude

import Effect.Aff (Aff)
import Test.Spec.Assertions (fail)
import Test.Utils.Assert.WithLocation (captureStackTrace) 

shouldEqual :: forall t. Show t => Eq t => t -> t -> Aff Unit
shouldEqual v1 v2 = do
  when (v1 /= v2) do
    let lineInfo = captureStackTrace unit
    let message = show v1 <> " ≠ " <> show v2 <> " (" <> lineInfo <> ")"
    fail message

infix 4 shouldEqual as ===
