module App.Component.Router.Menu.Style.Item.Icon.Icon
  ( statelessClass
  , style
  ) where

import Proem hiding (top, div)

import CSS (fromString, key)
import CSS as CSS
import Util.Style.Style (reflectStatelessClass, margin1, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    margin1 0.8
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"