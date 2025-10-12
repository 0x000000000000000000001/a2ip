module Util.Either
  ( (?!)
  , (?!⇽)
  , (?!⇾)
  , (⇿)
  , either
  , left
  , right
  )
  where

import Prelude (identity)

import Data.Either (Either)
import Data.Either as Either
import Data.Function (apply)

left :: ∀ o l. Either l o -> (l -> o) -> o
left e l = either e identity l

infixl 6 left as ?!⇽

right :: ∀ o r. Either o r -> (r -> o) -> o
right e r = either e r identity

infixl 6 right as ?!⇾

either :: ∀ l r o. Either l r -> (r -> o) -> (l -> o) -> o
either e r l = Either.either l r e

infixl 1 either as ?!

infixr 0 apply as ⇿