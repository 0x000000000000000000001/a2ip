module App.Component.Router.Menu.Style.Item.Item
  ( class'
  , staticClass
  , style
  )
  where

import App.Component.Router.Menu.Style.Item.Children as Children
import App.Component.Router.Menu.Style.Item.Icon.Container as IconContainer
import App.Component.Router.Menu.Style.Item.Label as Label
import App.Component.Router.Menu.Type (State)
import CSS (color, graytone, hover)
import CSS as CSS
import Proem (discard, when, ι)
import Util.Style.Style (alignItemsCenter, backgroundColorRed, cursorPointer, displayFlex, heightRem, inferClass, justifyContentCenter, noCss, padding2, positionRelative, raw, reflectStaticClass, userSelectNone, widthPct100, (.&), (.?), (:?), (|*.))

staticClass :: String 
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style { id, unfold } = do
  staticClass .? do
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

  ____iconContainer :? do
    IconContainer.boxShadow 0.22 0.10

  ____label :? do
    widthPct100

  class' id .? do
    noCss

  b_hover :? do
    noCss
    
  b___children :? do 
    when unfold displayFlex

  where
  __hover = staticClass .& hover
  ____children = __hover |*. Children.staticClass
  ____iconContainer = __hover |*. IconContainer.staticClass
  ____label = __hover |*. Label.staticClass
  b_hover = class' id .& hover
  b___children = b_hover |*. Children.staticClass

item :: ∀ w i. Node HTMLdiv w i
item props = div ([ class_ staticClass ] <> props)

item_ :: ∀ w i. Array (HTML w i) -> HTML w i
item_ = item []