module App.Component.Common.Link.Style.Link
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Link.Type (State)
import CSS (display, noneTextDecoration, textDecoration)
import CSS as CSS
import Util.Style.Style (inferClass, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' id = inferClass staticClass id

style :: State -> CSS.CSS
style { id, input: { display: display_ } } = do
  staticClass .? do 
    textDecoration noneTextDecoration

  class' id .? do
    display display_