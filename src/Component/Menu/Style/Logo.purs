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
classId = "e5b0045a-f64b-4f2d-9972-2c9993b89447"

style :: CSS.CSS
style = do
  classId <? do
    width (rem $ ItemIconContainer.width * 1.2)
    margin (rem 1.4) (rem 1.0) (rem 1.0) (rem 1.0)
    key (fromString "filter") "invert(1)"
    cursor pointer
    alignSelf center