module App.Component.Common.Vault.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Vault.Type (Action(..), VaultM, Output(..))
import Halogen (modify_)
import Halogen.Query.HalogenM (raise)

handleAction :: ∀ q i o. Action i o -> (VaultM q i o) Unit
handleAction = case _ of
  Receive input -> modify_ _ { innerInput = input.innerInput }
  
  RaiseInnerOutput output -> raise (InnerOutputRaised output)

  DoNothing -> ηι
