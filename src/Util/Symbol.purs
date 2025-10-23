module Util.Symbol
  ( ᴠ
  , ʌ
  )
  where

import Data.Symbol (class IsSymbol, reflectSymbol, reifySymbol)
import Type.Prelude (Proxy)

-- Type-level → Value-level
ᴠ :: ∀ sym. IsSymbol sym => Proxy sym -> String
ᴠ = reflectSymbol

-- Value-level → Type-level
ʌ :: ∀ r. String -> (∀ sym. IsSymbol sym => Proxy sym -> r) -> r
ʌ = reifySymbol