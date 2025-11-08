module App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State, Try(..))
import App.Component.Util.Type (Size(..), applyToSize)
import CSS (backgroundColor, height, width)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, justifyContentCenter, loading, loadingGrey, positionRelative, refineClass, reflectHashModuleName, (.?))

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
          { width: width'
          , height: height'
          , when: 
              { errored: 
                  { backgroundColor: backgroundColor'
                  }
              }
          }
      } 
  } = do
  statelessClass .? do 
    positionRelative

  statefulClass id .? do
    applyToSize width $ width' ??⇒ Auto
    applyToSize height $ height' ??⇒ Auto

    when (try == StopTrying) do
      displayFlex
      justifyContentCenter
      alignItemsCenter
      backgroundColor $ backgroundColor' ??⇒ loadingGrey

    when loading' do 
      loading
