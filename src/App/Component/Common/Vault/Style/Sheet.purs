module App.Component.Common.Vault.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Vault.Style.Vault as Vault
import App.Component.Common.Vault.Style.Core as Core
import App.Component.Common.Vault.Style.Front as Front
import App.Component.Common.Vault.Style.Message as Message

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Vault.style 
  Core.style
  Front.style
  Message.style