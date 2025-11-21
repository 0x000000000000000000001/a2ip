module Ui.Component.Page.Home.HandleVaultOutput
  ( handleVaultOutput
  )
  where


import Ui.Component.Common.Vault.Type as Vault
import Ui.Component.Page.Home.Type (Action(..))

handleVaultOutput :: ∀ o. Vault.Output o -> Action
handleVaultOutput _ = DoNothing
