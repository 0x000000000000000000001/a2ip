module Util.Async
  ( parTraverseBounded
  ) where

import Prelude

import Concurrent.BoundedQueue (BoundedQueue)
import Concurrent.BoundedQueue as BQ
import Control.Parallel (parTraverse)
import Data.Array ((!!), (..))
import Data.Maybe (fromJust)
import Data.Traversable (class Traversable, traverse, traverse_)
import Effect (Effect)
import Effect.Aff (Aff, bracket)
import Effect.Aff.AVar as AVar
import Effect.Class (liftEffect)
import Effect.Ref as Ref
import Partial.Unsafe (unsafePartial)

sem :: Int -> Effect (BoundedQueue Unit)
sem n = do
  q <- BQ.new n
  traverse_ (const $ BQ.write unit q) (1 .. n)
  pure q

semAcq :: BoundedQueue Unit -> Aff Unit
semAcq q = liftEffect (BQ.read q)

semRel :: BoundedQueue Unit -> Aff Unit
semRel q = liftEffect (BQ.write unit q)

parTraverseBounded
  :: forall f a b. Traversable f
  => Int          -- maxInFlight
  -> (a -> Aff b) -- action
  -> f a          -- inputs
  -> Aff (f b)
parTraverseBounded maxInFlight k xs = do
  s <- liftEffect $ sem maxInFlight
  parTraverse
    (\x ->
      bracket
        (semAcq s)
        (const $ semRel s)
        (const $ k x)
    )
    xs