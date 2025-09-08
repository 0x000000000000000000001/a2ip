module Component.Menu.Style.Item.Icon.Container
  ( classId
  , style
  , boxShadow
  , width
  ) where

import Prelude hiding (top, div)

import CSS (alignSelf, backgroundColor, borderRadius, display, flex, height, justifyContent, marginLeft, minWidth, rem, rgba, white)
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import Component.Menu.Style.Menu as MenuStyle
import Component.Menu.Type (State)
import Data.NonEmpty (singleton)
import Utils.Style ((<?))

width :: Number
width = 3.2

classId :: String
classId = "52837475-7c75-4cae-8e03-a71ef6825e4d"

boxShadow :: Number -> Number -> CSS.CSS
boxShadow x y = CSS.boxShadow $ singleton $ bsColor white $ shadow (rem x) (rem y)

style :: State -> CSS.CSS
style s = do
  classId <? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadius (rem 5.0) (rem 5.0) (rem 5.0) (rem 5.0)
    minWidth (rem width)
    CSS.width (rem width)
    height (rem width)
    marginLeft (rem $ (MenuStyle.foldWidth - width) / 2.0)
    display flex
    justifyContent center
    alignSelf center
    when s.isUnfold $ boxShadow 0.12 0.12