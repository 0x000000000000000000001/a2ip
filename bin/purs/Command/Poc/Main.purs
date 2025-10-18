module Bin.Command.Poc.Main (main) where

import Proem

import Effect (Effect)
import Effect.AVar (empty)
import Effect.Aff (launchAff_)
import Effect.Aff.AVar as AAVar
import Effect.Class (liftEffect)
import Effect.Console (log)
import Util.Aff (keepAlive)

main :: Effect Unit
main = launchAff_ $ keepAlive do
  avar <- liftEffect empty

  liftEffect $ log "before"

  _ <- AAVar.take avar

  liftEffect $ log "after"