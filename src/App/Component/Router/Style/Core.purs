module App.Component.Router.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as MenuStyle
import CSS as CSS
import Util.Style (backgroundColorWhite, borderRadius1, displayFlex, flexGrow1, margin4, padding1, (.?))

classId :: String
classId = "MvOJiB63k"

style :: CSS.CSS
style = do
  classId .? do
    margin4 2.0 2.0 2.0 $ 2.0 + MenuStyle.foldWidth
    displayFlex
    backgroundColorWhite
    padding1 1.0
    borderRadius1 0.6
    flexGrow1