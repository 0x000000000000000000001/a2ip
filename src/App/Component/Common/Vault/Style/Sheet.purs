module App.Component.Common.Vault.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Vault.Style.Vault as Vault
import App.Component.Common.Vault.Style.Core as Core
import App.Component.Common.Vault.Style.Door as Door
import App.Component.Common.Vault.Style.Front as Front
import App.Component.Common.Vault.Style.Lock as Lock
import App.Component.Common.Vault.Style.Message as Message

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Vault.style 
  Core.style
  Door.style
  Front.style
  Lock.style
  Message.style