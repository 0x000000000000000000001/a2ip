module Component.Menu.Style.Item.Icon.Container
  ( class'
  , containerBoxShadow
  , containerClass
  , containerStyle
  , style
  , width
  ) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, padding, position, rem, rgba, solid, top, vh, white, zIndex)
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center)
import CSS.Cursor (pointer)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Component.Menu.Style.Menu as MenuStyle
import Component.Menu.Type (State)
import Data.NonEmpty (singleton)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS as HCSS
import Utils.Style as StyleUtils

classId :: String
classId = "52837475-7c75-4cae-8e03-a71ef6825e4d"

class_ :: forall r i. HH.IProp (class :: String | r) i
class_ = StyleUtils.class_ classId

boxShadow :: Number -> Number -> CSS.CSS
boxShadow x y = boxShadow $ singleton $ bsColor white $ shadow (rem x) (rem y)

style :: State -> CSS.CSS
style s = do
  class' ? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadius (rem 5.0) (rem 5.0) (rem 5.0) (rem 5.0)
    minWidth (rem width)
    CSS.width (rem width)
    height (rem width)
    marginLeft (rem $ (MenuStyle.foldWidth - width) / 2.0)
    display flex
    justifyContent center
    alignSelf center
    when s.isUnfold $ containerBoxShadow 0.12 0.12