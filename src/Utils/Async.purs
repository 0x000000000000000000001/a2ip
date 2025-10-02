module Utils.Async
  ( parTraverseBounded
  ) where

import Prelude

import Control.Parallel (parTraverse)
import Data.Array ((..))
import Data.Traversable (class Traversable, traverse_)
import Effect.Aff (Aff, bracket)
import Effect.Aff.AVar (empty, put, take)
import Effect.Class (liftEffect)
import Effect.Console (log)

parTraverseBounded :: forall f a b. Traversable f => Int -> (a -> Aff b) -> f a -> Aff (f b)
parTraverseBounded maxInFlight k xs = do
  gate <- empty
  let putToken = put unit gate
  traverse_ (const putToken) (1 .. maxInFlight)
  parTraverse
    (\x ->
      bracket
        ((liftEffect $ log "abc") *> take gate)
        (\_ -> putToken)
        (\_ -> k x)
    )
    xs