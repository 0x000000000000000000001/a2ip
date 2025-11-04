module App.Component.Common.Vault.HandlePasswordOutput
  ( handlePasswordOutput
  ) where

import App.Component.Common.Input.Type (Output(..))
import App.Component.Common.Input.Type as Input
import App.Component.Common.Vault.Type (Action(..))

handlePasswordOutput :: ∀ i o. Input.Output -> Action i o
handlePasswordOutput (ChangedValue newValue) = HandleNewPasswordInputValue newValue
