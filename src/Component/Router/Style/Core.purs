module Component.Router.Style.Core
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (backgroundColor, borderRadius, display, flex, flexGrow, fromInt, margin, rem)
import CSS as CSS
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Component.Router.Menu.Style.Menu as MenuStyle
import Utils.Style (padding, (<?))

classId :: String
classId = "MvOJiB63k"

style :: CSS.CSS
style = do
  classId <? do
    margin (rem 2.0) (rem 2.0) (rem 2.0) (rem $ 2.0 + MenuStyle.foldWidth)
    display flex
    backgroundColor (fromInt 0xffffff)
    padding 1.0
    borderRadius (rem 0.6) (rem 0.6) (rem 0.6) (rem 0.6)
    overflow Overflow.hidden
    flexGrow 1.0