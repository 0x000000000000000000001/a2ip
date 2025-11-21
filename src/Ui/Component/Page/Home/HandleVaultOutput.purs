module App.Component.Page.Home.HandleVaultOutput
  ( handleVaultOutput
  )
  where


import App.Component.Common.Vault.Type as Vault
import App.Component.Page.Home.Type (Action(..))

handleVaultOutput :: ∀ o. Vault.Output o -> Action
handleVaultOutput _ = DoNothing
