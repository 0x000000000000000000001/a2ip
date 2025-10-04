module Util.Async
  ( parTraverseBounded
  ) where

import Prelude

import Concurrent.BoundedQueue (BoundedQueue)
import Concurrent.BoundedQueue as BQ
import Control.Parallel (parTraverse)
import Data.Array ((..))
import Data.Traversable (class Traversable, traverse_)
import Effect.Aff (Aff, bracket)

sem :: Int -> Aff (BoundedQueue Unit)
sem n = do
  q <- BQ.new n
  traverse_ (const $ BQ.write q unit) (1 .. n)
  pure q

semAcq :: BoundedQueue Unit -> Aff Unit
semAcq q = BQ.read q

semRel :: BoundedQueue Unit -> Aff Unit
semRel q = BQ.write q unit

parTraverseBounded
  :: forall f a b. Traversable f
  => Int          -- maxInFlight
  -> (a -> Aff b) -- action
  -> f a          -- inputs
  -> Aff (f b)
parTraverseBounded maxInFlight k xs = do
  s <- sem maxInFlight
  parTraverse
    (\x ->
      bracket
        (semAcq s)
        (const $ semRel s)
        (const $ k x)
    )
    xs