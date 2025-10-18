module Bin.Command.Poc.Main (main) where

import Proem

import Effect (Effect)
import Effect.AVar (empty)
import Effect.Aff (Milliseconds(..), delay, forkAff, runAff)
import Effect.Aff.AVar as AAVar
import Effect.Class (liftEffect)
import Effect.Console (log, logShow)
import Util.Aff (keepProcessAlive)

main :: Effect Unit
main = do
  void $ runAff logShow $ keepProcessAlive do
    avar <- liftEffect empty

    liftEffect $ log "before"

    _ <- AAVar.take avar

    liftEffect $ log "after"