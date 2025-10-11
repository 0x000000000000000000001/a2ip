module Util.Semaphor
  ( Sem
  , lock
  , lockAcq
  , lockRel
  , parTraverseBounded
  , sem
  , semAcq
  , semRel
  )
  where

import Proem

import Concurrent.BoundedQueue (BoundedQueue)
import Concurrent.BoundedQueue as BQ
import Control.Parallel (parTraverse)
import Data.Array ((..))
import Data.Traversable (class Traversable, traverse_)
import Effect.Aff (Aff, bracket)
import Effect.Aff.Class (class MonadAff, liftAff)

type Sem = BoundedQueue Unit

sem :: ∀ m. MonadAff m => Int -> m Sem
sem n = do
  s <- liftAff $ BQ.new n
  traverse_ (const $ liftAff $ BQ.write s unit) (1 .. n)
  pure s

semAcq :: ∀ m. MonadAff m => Sem -> m Unit
semAcq s = liftAff $ BQ.read s

semRel :: ∀ m. MonadAff m => Sem -> m Unit
semRel q = liftAff $ BQ.write q unit

lock :: ∀ m. MonadAff m => m Sem
lock = sem 1

lockAcq :: ∀ m. MonadAff m => Sem -> m Unit
lockAcq s = semAcq s

lockRel :: ∀ m. MonadAff m => Sem -> m Unit
lockRel s = semRel s

parTraverseBounded
  :: ∀ m t a b. MonadAff m => Traversable t
  => Int          -- maxInFlight
  -> (a -> Aff b) -- action
  -> t a          -- inputs
  -> m (t b)
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