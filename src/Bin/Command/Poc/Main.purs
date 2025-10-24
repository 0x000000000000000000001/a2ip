module Bin.Command.Poc.Main (main) where

import Proem

import Bin.Util.Capability.BinM (runBinM)
import Config.Config (config)
import Effect (Effect)
import Effect.AVar (empty)
import Effect.Aff.AVar as AAVar
import Effect.Console (log)
import Util.Aff (keepAlive)

main :: Effect Unit
main = runBinM config $ keepAlive do
  avar <- ʌ' $ ʌ empty

  ʌ' $ ʌ $ log "before"

  void $ ʌ' $ AAVar.take avar

  ʌ' $ ʌ $ log "after"