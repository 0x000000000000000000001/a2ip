module Util.Lab
  ( (∇)
  , _reflectSymbol
  , λ
  )
  where

import Prelude

import Data.Symbol (class IsSymbol, reflectSymbol)
import Type.Prelude (Proxy)

λ :: Unit
λ = unit

_reflectSymbol :: ∀ sym. IsSymbol sym => Unit -> Proxy sym -> String
_reflectSymbol _ sym = reflectSymbol sym

infix 9 _reflectSymbol as ∇