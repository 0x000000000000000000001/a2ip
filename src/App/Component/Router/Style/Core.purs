module App.Component.Router.Style.Core
  ( staticClass
  , style
  , zIndex
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as Menu
import CSS as CSS
import Util.Style.Style (backgroundColorWhite, borderRadiusRem1, displayFlex, flexGrow1, reflectStaticClass, margin4, padding1, positionRelative, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

zIndex :: Int
zIndex = Menu.zIndex - 10

style :: CSS.CSS
style = do
  staticClass .? do
    margin4 2.0 2.0 2.0 $ 2.0 + Menu.foldWidth
    displayFlex
    backgroundColorWhite
    padding1 1.0
    borderRadiusRem1 0.6
    flexGrow1
    positionRelative
    CSS.zIndex zIndex