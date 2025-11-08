module App.Component.Common.PrettyErrorImage.Style.Image
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import CSS (opacity)
import CSS as CSS
import Util.Style.Image (fill, objectFit)
import Util.Style.Style (heightPct100, inferStatefulClass, reflectStatelessClass, widthPct100, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

statefulClass :: String -> String
statefulClass = inferStatefulClass statelessClass

style :: State -> CSS.CSS
style 
  { id
  , input: 
      { loading: loading' 
      , style: 
          { fit
          }
      } 
  } = do
  statelessClass .? do 
    widthPct100
    heightPct100

  statefulClass id .? do
    objectFit $ fit ??⇒ fill

    when loading' do 
      opacity 0.0
