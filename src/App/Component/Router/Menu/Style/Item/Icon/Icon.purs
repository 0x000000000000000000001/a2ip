module App.Component.Router.Menu.Style.Item.Icon.Icon
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import CSS (fromString, key)
import CSS as CSS
import Util.Style (reflectHashModuleName, margin1, (.?))

classId :: String
classId = reflectHashModuleName ι

style :: CSS.CSS
style = do
  classId .? do
    margin1 0.8
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"