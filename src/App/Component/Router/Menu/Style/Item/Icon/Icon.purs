module App.Component.Router.Menu.Style.Item.Icon.Icon
  ( staticClass
  , style
  ) where

import Proem hiding (top, div)

import CSS (fromString, key)
import CSS as CSS
import Util.Style.Style (reflectStaticClass, margin1, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    margin1 0.8
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"