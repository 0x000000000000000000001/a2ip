module Util.Symbol
  ( ᴠ
  , τ
  )
  where

import Data.Symbol (class IsSymbol, reflectSymbol, reifySymbol)
import Type.Prelude (Proxy)

-- Type-level → Value-level
ᴠ :: ∀ sym. IsSymbol sym => Proxy sym -> String
ᴠ = reflectSymbol

-- Value-level → Type-level
τ :: ∀ r. String -> (∀ sym. IsSymbol sym => Proxy sym -> r) -> r
τ = reifySymbol