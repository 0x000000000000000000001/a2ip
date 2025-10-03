module Util.Async
  ( parTraverseBounded
  ) where

import Prelude

import Control.Parallel (parTraverse)
import Data.Array ((!!), (..))
import Data.Maybe (fromJust)
import Data.Traversable (class Traversable, traverse)
import Effect.Aff (Aff, bracket)
import Effect.Aff.AVar as AVar
import Effect.Class (liftEffect)
import Effect.Ref as Ref
import Partial.Unsafe (unsafePartial)

parTraverseBounded :: forall f a b. Traversable f => Int -> (a -> Aff b) -> f a -> Aff (f b)
parTraverseBounded maxInFlight k xs = do
  -- Create multiple AVars, each representing one token
  -- This avoids race conditions
  tokens <- traverse (\_ -> do
    avar <- AVar.new unit
    pure avar
  ) (1 .. maxInFlight)
  
  -- Use a mutable counter to distribute tokens in round-robin
  counter <- liftEffect $ Ref.new 0
  
  result <- parTraverse
    (\x -> do
      -- Get the next token AVar in round-robin fashion
      idx <- liftEffect do
        current <- Ref.read counter
        Ref.modify_ (\n -> (n + 1) `mod` maxInFlight) counter
        pure current
      
      let tokenAVar = unsafePartial $ fromJust $ tokens !! idx
      
      bracket
        -- Acquire: take from this specific token AVar (blocks if not available)
        (AVar.take tokenAVar)
        -- Release: put the token back
        (const $ AVar.put unit tokenAVar)
        -- Use: execute the action
        (const $ k x)
    )
    xs

  pure result