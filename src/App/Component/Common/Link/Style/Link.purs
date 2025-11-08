module App.Component.Common.Link.Style.Link
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Link.Type (State)
import CSS (display, noneTextDecoration, textDecoration)
import CSS as CSS
import Util.Style.Style (inferStatefulClass, reflectStatelessClass, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

statefulClass :: String -> String
statefulClass id = inferStatefulClass statelessClass id

style :: State -> CSS.CSS
style { id, input: { display: display_ } } = do
  statelessClass .? do 
    textDecoration noneTextDecoration

  statefulClass id .? do
    display display_