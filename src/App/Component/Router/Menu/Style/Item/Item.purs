module App.Component.Router.Menu.Style.Item.Item
  ( classId
  , style
  ) where

import Proem (discard, when, ι)
import App.Component.Router.Menu.Style.Item.Children as Children
import App.Component.Router.Menu.Style.Item.Icon.Container as IconContainer
import App.Component.Router.Menu.Style.Item.Label as Label
import App.Component.Router.Menu.Type (State)
import CSS (color, graytone, hover)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, backgroundColorRed, cursorPointer, displayFlex, reflectStatelessClass, heightRem, justifyContentCenter, padding2, positionRelative, raw, typedDeepClass, userSelectNone, widthPct100, (.&), (.?), (:?))

classId :: String 
classId = reflectStatelessClass ι

style :: State -> CSS.CSS
style s = do
  classId .? do
    color (graytone 0.9)
    justifyContentCenter
    alignItemsCenter
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
    when s.unfold displayFlex

  ____iconContainer :? do
    IconContainer.boxShadow 0.22 0.10

  ____label :? do
    widthPct100

  where
  __hover = classId .& hover
  deepClassHover = typedDeepClass __hover
  ____children = deepClassHover Children.classId
  ____iconContainer = deepClassHover IconContainer.classId
  ____label = deepClassHover Label.classId