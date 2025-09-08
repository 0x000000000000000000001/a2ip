module Component.Menu.Style.Item.Item
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (alignItems, backgroundColor, color, cursor, display, flex, graytone, hover, justifyContent, padding, rem, (?))
import CSS as CSS
import CSS.Common (center)
import CSS.Cursor (pointer)
import Component.Menu.Style.Item.Icon.Container as IconContainer
import Utils.Style (ourRed, (<?), (<|*), (<&))

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

  hoverSel ? do
    backgroundColor ourRed

  (hoverSel <|* IconContainer.classId) ? (IconContainer.boxShadow 0.22 (-0.10))

  where
  hoverSel = classId <& hover