module Util.Condition
  ( (?)
  , (↔)
  , if_
  )
  where

import Data.Function (apply)

if_ :: ∀ a. Boolean -> a -> a -> a
if_ b t e = if b then t else e

infixl 1 if_ as ?

infixr 0 apply as ↔