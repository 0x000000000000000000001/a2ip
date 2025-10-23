module App.Component.Router.Menu.Style.Sheet
  ( sheet
  ) where

import Proem

import App.Component.Router.Menu.Style.Item.Index as Item
import App.Component.Router.Menu.Style.Logo as Logo
import App.Component.Router.Menu.Style.Menu as Menu
import App.Component.Router.Menu.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i. State -> HTML p i
sheet s = stylesheet do
  Menu.style s
  Item.style s
  Logo.style