module Util.Lab
  ( (↓)
  , (↑)
  , reflectSymbol_
  , reifySymbol_
  , λ
  )
  where

import Prelude

import Data.Symbol (class IsSymbol, reflectSymbol, reifySymbol)
import Type.Prelude (Proxy)

λ :: Unit
λ = unit

-- Type-level → Value-level
reflectSymbol_ :: ∀ sym. IsSymbol sym => Unit -> Proxy sym -> String
reflectSymbol_ _ = reflectSymbol

infix 9 reflectSymbol_ as ↓

-- Value-level → Type-level
reifySymbol_ :: ∀ r. Unit -> String -> (∀ sym. IsSymbol sym => Proxy sym -> r) -> r
reifySymbol_ _ str f = reifySymbol str f

infix 9 reifySymbol_ as ↑