module Api.Sync (sync) where

import Proem

import Cli.Command.Sync.Main as Cli
import Effect.Aff (Aff)

sync :: (String -> Aff Unit) -> Aff Unit
sync log = Cli.sync log log log 
