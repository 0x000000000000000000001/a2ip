module Component.Router.Menu.Style.Item.Item
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (alignItems, backgroundColor, color, cursor, display, flex, graytone, height, hover, justifyContent, padding, pct, position, relative, rem, width, (?))
import CSS as CSS
import CSS.Common (center)
import CSS.Cursor (pointer)
import Component.Router.Menu.Style.Item.Children as Children
import Component.Router.Menu.Style.Item.Icon.Container as IconContainer
import Component.Router.Menu.Style.Item.Label as Label
import Utils.Style (deep, ourRed, (<&), (<?))

classId :: String
classId = "hJyLm9YwK"

style :: CSS.CSS
style = do
  classId <? do
    color (graytone 0.9)
    display flex
    justifyContent center
    alignItems center
    cursor pointer
    padding (rem 0.7) (rem 0.0) (rem 0.7) (rem 0.0)
    position relative
    width (pct 100.0)
    height $ rem IconContainer.width
    CSS.key (CSS.fromString "transition") "background-color 0s"

  hover' ? do
    backgroundColor ourRed

  o Children.classId ? (display flex)
  o IconContainer.classId ? (IconContainer.boxShadow 0.22 (-0.10))
  o Label.classId ? (width $ pct 100.0)

  where
  hover' = classId <& hover
  o = deep hover'