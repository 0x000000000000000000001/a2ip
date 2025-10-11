module Component.Router.Menu.Style.Sheet
  ( sheet
  ) where

import Proem

import Component.Router.Menu.Style.Item.Index as Item
import Component.Router.Menu.Style.Logo as Logo
import Component.Router.Menu.Style.Menu as Menu
import Component.Router.Menu.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: forall p i. State -> HTML p i
sheet s = stylesheet do
  Menu.style s
  Item.style s
  Logo.style