module App.Component.Common.Modal.Style.Core.Core
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as Menu
import CSS as CSS
import Util.Style.Style (backgroundColorWhite, borderRadiusRem1, margin2, padding1, positionRelative, reflectStaticClass, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    positionRelative
    backgroundColorWhite
    widthRem 60.0
    padding1 2.0
    borderRadiusRem1 0.5
    margin2 8.0 2.0

  Menu.staticClass .? do
    CSS.zIndex $ -1