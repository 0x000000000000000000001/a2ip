module Test.Util.Assert ((===), shouldEqual) where

import Proem

import Effect.Aff (Aff)
import Test.Spec.Assertions (fail)

foreign import captureTrace :: Unit -> String

shouldEqual :: forall t. Show t => Eq t => t -> t -> Aff Unit
shouldEqual v1 v2 = do
  when (v1 /= v2) do
    let trace = captureTrace unit
    let message = show v1 <> " ≠ " <> show v2 <> "\n  @ " <> trace
    fail message

infix 4 shouldEqual as ===
