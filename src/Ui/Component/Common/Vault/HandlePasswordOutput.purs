module Ui.Component.Common.Vault.HandlePasswordOutput
  ( handlePasswordOutput
  ) where

import Ui.Component.Common.Input.Type (Output(..))
import Ui.Component.Common.Input.Type as Input
import Ui.Component.Common.Vault.Type (Action(..))

handlePasswordOutput :: ∀ i o. Input.Output -> Action i o
handlePasswordOutput (ChangedValue newValue) = HandleNewPasswordInputValue newValue
