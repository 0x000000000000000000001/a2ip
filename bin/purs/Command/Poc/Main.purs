module Bin.Command.Poc.Main (main) where

import Proem

import Effect (Effect)
import Effect.AVar (empty, tryTake)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Console (log)

main :: Effect Unit
main = launchAff_ do
  avar <- liftEffect $ empty
  liftEffect $ log "before"
  _ <- liftEffect $ tryTake avar
  liftEffect $ log "after"