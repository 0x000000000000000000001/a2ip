module Ui.Component.Router.Menu.Style.Item.Icon.Index
  ( style
  ) where

import Proem

import CSS as CSS
import Ui.Component.Router.Menu.Style.Item.Icon.Container as Container
import Ui.Component.Router.Menu.Style.Item.Icon.Icon as Icon
import Ui.Component.Router.Menu.Type (State)

style :: State -> CSS.CSS
style s = do
  Container.style s
  Icon.style