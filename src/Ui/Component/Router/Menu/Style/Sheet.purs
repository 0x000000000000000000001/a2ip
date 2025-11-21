module Ui.Component.Router.Menu.Style.Sheet
  ( sheet
  ) where

import Proem

import Ui.Component.Router.Menu.Style.Item.Index as Item
import Ui.Component.Router.Menu.Style.Logo as Logo
import Ui.Component.Router.Menu.Style.Menu as Menu
import Ui.Component.Router.Menu.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ w i. State -> HTML w i
sheet s = stylesheet do
  Menu.style s
  Item.style s
  Logo.style