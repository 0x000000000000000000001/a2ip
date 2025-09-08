module Component.Menu.Style.Logo
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (alignSelf, cursor, fromString, key, margin, rem, width)
import CSS as CSS
import CSS.Common (center)
import CSS.Cursor (pointer)
import Component.Menu.Style.Item.Icon.Container as ItemIconContainer
import Utils.Style ((<?))

classId :: String
classId = "18c917b2-3715-43f3-86db-d3527bd8c4d6"

style :: CSS.CSS
style = do
  classId <? do
    width (rem $ ItemIconContainer.width * 1.2)
    margin (rem 1.4) (rem 1.0) (rem 1.0) (rem 1.0)
    key (fromString "filter") "invert(1)"
    cursor pointer
    alignSelf center