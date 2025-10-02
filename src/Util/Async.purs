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
import Effect.Console (log)
import Effect.Ref as Ref
import Partial.Unsafe (unsafePartial)

parTraverseBounded :: forall f a b. Traversable f => Int -> (a -> Aff b) -> f a -> Aff (f b)
parTraverseBounded maxInFlight k xs = do
  liftEffect $ log $ "parTraverseBounded: creating " <> show maxInFlight <> " token AVars"
  
  -- Create multiple AVars, each representing one token
  -- This avoids race conditions
  tokens <- traverse (\_ -> do
    avar <- AVar.new unit
    pure avar
  ) (1 .. maxInFlight)
  
  liftEffect $ log "parTraverseBounded: starting parTraverse"
  
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
      
      liftEffect $ log $ "parTraverseBounded: task acquiring token #" <> show idx
      
      bracket
        -- Acquire: take from this specific token AVar (blocks if not available)
        (do
          liftEffect $ log $ "parTraverseBounded: taking token #" <> show idx
          AVar.take tokenAVar
        )
        -- Release: put the token back
        (\_ -> do
          liftEffect $ log $ "parTraverseBounded: releasing token #" <> show idx
          AVar.put unit tokenAVar
        )
        -- Use: execute the action
        (\_ -> do
          liftEffect $ log "parTraverseBounded: executing action"
          k x
        )
    )
    xs
  liftEffect $ log "parTraverseBounded: parTraverse completed"
  pure result