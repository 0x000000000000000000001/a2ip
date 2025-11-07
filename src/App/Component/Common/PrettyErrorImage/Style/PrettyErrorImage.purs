module App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State, Try(..))
import CSS (backgroundColor)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, justifyContentCenter, loading, nothing, refineClass, reflectHashModuleName, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClass statelessClass id

style :: State -> CSS.CSS
style 
  { id
  , try
  , input: 
      { loading: loading' 
      , style: 
          { when: 
              { errored: 
                  { backgroundColor: backgroundColor'
                  }
              }
          }
      } 
  } = do
  statelessClass .? do 
    nothing

  statefulClass id .? do 
    when (try == StopTrying) do
      displayFlex
      justifyContentCenter
      alignItemsCenter
      backgroundColor backgroundColor'

    when loading' do 
      loading
