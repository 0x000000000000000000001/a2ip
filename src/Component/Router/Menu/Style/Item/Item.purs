module Component.Router.Menu.Style.Item.Item
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import CSS (alignItems, color, graytone, hover, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Component.Router.Menu.Style.Item.Children as Children
import Component.Router.Menu.Style.Item.Icon.Container as IconContainer
import Component.Router.Menu.Style.Item.Label as Label
import Util.Style (backgroundColorRed, cursorPointer, deepClass, displayFlex, heightRem, padding2, positionRelative, raw, userSelectNone, widthPct100, (.&), (.?), (:?))

classId :: String 
classId = "hJyLm9YwK"

style :: CSS.CSS
style = do
  classId .? do
    color (graytone 0.9)
    justifyContent center
    alignItems center
    cursorPointer
    padding2 0.7 0.0
    positionRelative 
    widthPct100
    heightRem IconContainer.width
    raw "transition" "background-color 0s"
    userSelectNone
 
  __hover :? do
    backgroundColorRed

  ____children :? do 
    displayFlex

  ____iconContainer :? do
    IconContainer.boxShadow 0.22 0.10

  ____label :? do
    widthPct100

  where
  __hover = classId .& hover
  deepClassHover = deepClass __hover
  ____children = deepClassHover Children.classId
  ____iconContainer = deepClassHover IconContainer.classId
  ____label = deepClassHover Label.classId