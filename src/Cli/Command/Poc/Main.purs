module Cli.Command.Poc.Main (main) where

import Proem

import Cli.Util.Capability.BinM (runBinM)
import Effect (Effect)
import Effect.AVar (empty)
import Effect.Aff.AVar as AAVar
import Effect.Console (log)

main :: Effect Unit
main = runBinM true do
  avar <- ʌ' $ ʌ empty

  ʌ' $ ʌ $ log "before"

  ø $ ʌ' $ AAVar.take avar

  ʌ' $ ʌ $ log "after"