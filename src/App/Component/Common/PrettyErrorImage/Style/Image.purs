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
import Util.Style.Style (heightPct100, positionRelative, refineClass, reflectHashModuleName, widthPct100, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClass statelessClass id

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
    positionRelative
    widthPct100
    heightPct100

  statefulClass id .? do
    objectFit $ fit ??⇒ fill

    when loading' do 
      opacity 0.0
