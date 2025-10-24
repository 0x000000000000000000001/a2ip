module Util.Functor
  ( ø
  )
  where

import Prelude

ø :: ∀ f a. Functor f => f a -> f Unit
ø = void