module Component.Menu.Style.Item.Icon.Icon
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (fromString, key, margin, rem)
import CSS as CSS
import Utils.Style ((<?))

classId :: String
classId = "c093a814-b70b-4ef6-941a-79b79959f3e4"

style :: CSS.CSS
style = do
  classId <? do
    margin (rem 0.8) (rem 0.8) (rem 0.8) (rem 0.8)
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"