module Util.Either
  ( (?!)
  , (⇿)
  , either
  )
  where

import Data.Either (Either)
import Data.Either as Either
import Data.Function (apply)

either :: ∀ a b c. Either a b -> (a -> c) -> (b -> c) -> c
either e l r = Either.either l r e

infixl 1 either as ?!

infixr 0 apply as ⇿