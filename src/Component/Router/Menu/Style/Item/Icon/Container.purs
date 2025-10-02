module Component.Router.Menu.Style.Item.Icon.Container
  ( classId
  , style
  , boxShadow
  , width
  ) where

import Prelude hiding (top, div)

import CSS (alignSelf, backgroundColor, justifyContent, rem, rgba, white)
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import Component.Router.Menu.Style.Menu as MenuStyle
import Component.Router.Menu.Type (State)
import Data.NonEmpty (singleton)
import Util.Style (borderRadius1, displayFlex, heightRem, marginLeft, minWidthRem, widthRem, (.?))

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
    borderRadius1 5.0
    minWidthRem width
    widthRem width
    heightRem width
    marginLeft $ (MenuStyle.foldWidth - width) / 2.0
    displayFlex
    justifyContent center 
    alignSelf center
    when s.isUnfold $ boxShadow 0.12 0.12