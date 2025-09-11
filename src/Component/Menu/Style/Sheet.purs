module Component.Menu.Style.Sheet
  ( sheet
  ) where

import Prelude

import Component.Menu.Style.Item.Icon.Container as ItemIconContainer
import Component.Menu.Style.Item.Icon.Icon as ItemIcon
import Component.Menu.Style.Item.Item as Item
import Component.Menu.Style.Item.Child as Child
import Component.Menu.Style.Item.Children as Children
import Component.Menu.Style.Item.Label as ItemLabel
import Component.Menu.Style.Logo as Logo
import Component.Menu.Style.Menu (style)
import Component.Menu.Type (State)
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