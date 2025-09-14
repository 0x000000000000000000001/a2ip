module Component.Router.Menu.Style.Sheet
  ( sheet
  ) where

import Prelude

import Component.Router.Menu.Style.Item.Icon.Container as ItemIconContainer
import Component.Router.Menu.Style.Item.Icon.Icon as ItemIcon
import Component.Router.Menu.Style.Item.Item as Item
import Component.Router.Menu.Style.Item.Child as Child
import Component.Router.Menu.Style.Item.Children as Children
import Component.Router.Menu.Style.Item.Label as ItemLabel
import Component.Router.Menu.Style.Logo as Logo
import Component.Router.Menu.Style.Menu (style)
import Component.Router.Menu.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: forall p i. State -> HTML p i
sheet s = stylesheet do
  style s
  Child.style
  Children.style
  Item.style
  ItemIconContainer.style s
  ItemIcon.style
  ItemLabel.style s
  Logo.style