module Ui.Component.Common.Vault.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Ui.Component.Common.Vault.Style.Vault as Vault
import Ui.Component.Common.Vault.Style.Core as Core
import Ui.Component.Common.Vault.Style.Door as Door
import Ui.Component.Common.Vault.Style.Front as Front
import Ui.Component.Common.Vault.Style.Lock as Lock
import Ui.Component.Common.Vault.Style.Message as Message

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Vault.style 
  Core.style
  Door.style
  Front.style
  Lock.style
  Message.style