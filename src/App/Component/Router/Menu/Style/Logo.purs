module App.Component.Router.Menu.Style.Logo
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Item.Icon.Container as ItemIconContainer
import CSS (alignSelf, fromString, key)
import CSS as CSS
import CSS.Common (center)
import Util.Style.Style (cursorPointer, reflectStatelessClass, margin4, widthRem, (.?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    widthRem $ ItemIconContainer.width * 1.2
    margin4 1.4 1.0 1.0 1.0
    key (fromString "filter") "invert(1)"
    cursorPointer
    alignSelf center