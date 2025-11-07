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
import Data.Maybe (isJust)
import Util.Style.Image (fill, objectFit)
import Util.Style.Style (alignItemsCenter, displayFlex, justifyContentCenter, loading, loadingGrey, nothing, refineClass, reflectHashModuleName, (.?))

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
          { fit
          , when: 
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
    when (isJust fit) do 
      objectFit $ fit ??⇒ fill

    when (try == StopTrying) do
      displayFlex
      justifyContentCenter
      alignItemsCenter
      backgroundColor $ backgroundColor' ??⇒ loadingGrey

    when loading' do 
      loading
