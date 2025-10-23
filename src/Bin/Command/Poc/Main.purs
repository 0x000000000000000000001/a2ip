module Bin.Command.Poc.Main (main) where

import Proem

import Bin.Util.Capability.BinM (runBinM)
import Config.Config (config)
import Effect (Effect)
import Effect.AVar (empty)
import Effect.Aff.AVar as AAVar
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Util.Aff (keepAlive)

main :: Effect Unit
main = runBinM config $ keepAlive do
  avar <- liftAff $ liftEffect empty

  liftAff $ liftEffect $ log "before"

  _ <- liftAff $ AAVar.take avar

  liftAff $ liftEffect $ log "after"