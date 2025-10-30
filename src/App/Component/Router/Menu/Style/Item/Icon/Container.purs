module App.Component.Router.Menu.Style.Item.Icon.Container
  ( classId
  , style
  , boxShadow
  , width
  ) where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu as MenuStyle
import App.Component.Router.Menu.Type (State)
import CSS (alignSelf, backgroundColor, rem, rgba, white)
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import Data.NonEmpty (singleton)
import Util.Style (borderRadiusPct1, displayFlex, heightRem, justifyContentCenter, marginLeft, minWidthRem, widthRem, (.?))

width :: Number
width = 3.2

classId :: String
classId = "gcMO1hLjZ"

boxShadow :: Number -> Number -> CSS.CSS
boxShadow x y = CSS.boxShadow $ singleton $ bsColor white $ shadow (rem x) (rem y)

style :: State -> CSS.CSS
style s = do
  classId .? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadiusPct1 50.0
    minWidthRem width
    widthRem width
    heightRem width
    marginLeft $ (MenuStyle.foldWidth - width) / 2.0
    displayFlex
    justifyContentCenter
    alignSelf center
    when s.unfold $ boxShadow 0.12 0.12