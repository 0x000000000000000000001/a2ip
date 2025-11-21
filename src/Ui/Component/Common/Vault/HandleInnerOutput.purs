module Ui.Component.Common.Vault.HandleInnerOutput
  ( handleInnerOutput
  ) where

import Ui.Component.Common.Vault.Type (Action(..))

handleInnerOutput :: ∀ i o. o -> Action i o
handleInnerOutput output = RaiseInnerOutput output
