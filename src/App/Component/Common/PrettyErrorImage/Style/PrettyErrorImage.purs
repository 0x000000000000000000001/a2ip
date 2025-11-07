module App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State, Try(..))
import CSS (backgroundColor, height, width)
import CSS as CSS
import CSS.Common (auto)
import Util.Style.Image (fill, objectFit)
import Util.Style.Style (alignItemsCenter, displayFlex, justifyContentCenter, loading, loadingGrey, positionRelative, refineClass, reflectHashModuleName, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClass statelessClass id

style :: ∀ u. State u -> CSS.CSS
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
    width $ width' ??⇒ auto
    height $ height' ??⇒ auto

    when (try == StopTrying) do
      displayFlex
      justifyContentCenter
      alignItemsCenter
      backgroundColor $ backgroundColor' ??⇒ loadingGrey

    when loading' do 
      loading
