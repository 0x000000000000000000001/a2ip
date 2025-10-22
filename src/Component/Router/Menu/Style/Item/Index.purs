module Component.Router.Menu.Style.Item.Index
  ( style
  ) where

import Proem

import CSS as CSS
import Component.Router.Menu.Style.Item.Child as Child
import Component.Router.Menu.Style.Item.Children as Children
import Component.Router.Menu.Style.Item.Item as Item
import Component.Router.Menu.Style.Item.Label as Label
import Component.Router.Menu.Style.Item.Icon.Index as Icon
import Component.Router.Menu.Type (State)

style :: State -> CSS.CSS
style s = do
  Icon.style s
  Item.style s
  Label.style s
  Child.style
  Children.style