module Util.Function
  ( (▷)
  , (◁)
  , κ
  )
  where

import Prelude (const)

import Control.Semigroupoid (compose, composeFlipped)

infixr 9 compose as ◁

infixr 9 composeFlipped as ▷

κ :: forall a b. a -> b -> a
κ = const

