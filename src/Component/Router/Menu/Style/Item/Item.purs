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
import Utils.Style (deep_, raw, red, (<&), (<?))

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
    raw "transition" "background-color 0s"
 
  __hover ? do
    backgroundColor red

  ____children ? do 
    display flex

  ____iconContainer ? do
    IconContainer.boxShadow 0.22 0.10

  ____label ? do
    width (pct 100.0)

  where
  __hover = classId <& hover
  deepHover = deep_ __hover
  ____children = deepHover Children.classId
  ____iconContainer = deepHover IconContainer.classId
  ____label = deepHover Label.classId