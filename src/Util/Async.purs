module Util.Async
  ( Sem
  , parTraverseBounded
  , sem
  , semAcq
  , semRel
  )
  where

import Prelude

import Concurrent.BoundedQueue (BoundedQueue)
import Concurrent.BoundedQueue as BQ
import Control.Parallel (parTraverse)
import Data.Array ((..))
import Data.Traversable (class Traversable, traverse_)
import Effect.Aff (Aff, bracket)
import Effect.Aff.Class (class MonadAff, liftAff)

type Sem = BoundedQueue Unit

sem :: forall m. MonadAff m => Int -> m Sem
sem n = do
  q <- liftAff $ BQ.new n
  traverse_ (const $ liftAff $ BQ.write q unit) (1 .. n)
  pure q

semAcq :: forall m. MonadAff m => Sem -> m Unit
semAcq q = liftAff $ BQ.read q

semRel :: forall m. MonadAff m => Sem -> m Unit
semRel q = liftAff $ BQ.write q unit

parTraverseBounded
  :: forall m f a b. MonadAff m => Traversable f
  => Int          -- maxInFlight
  -> (a -> Aff b) -- action
  -> f a          -- inputs
  -> m (f b)
parTraverseBounded maxInFlight k xs = do
  s <- sem maxInFlight
  liftAff $ parTraverse
    (\x ->
      bracket
        (semAcq s)
        (const $ semRel s)
        (const $ k x)
    )
    xs