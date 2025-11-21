module App.Component.Common.Vault.HandleInnerOutput
  ( handleInnerOutput
  ) where

import App.Component.Common.Vault.Type (Action(..))

handleInnerOutput :: ∀ i o. o -> Action i o
handleInnerOutput output = RaiseInnerOutput output
