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
import Util.Style (displayFlex, justifyContentCenter, loading, loadingGrey, nothing, refineClass, reflectHashModuleName, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClass statelessClass id

style :: State -> CSS.CSS
style { id, try, input: { loading: loading' } } = do
  statelessClass .? do 
    nothing

  statefulClass id .? do 
    let errored = case try of
          StopTrying -> true
          _          -> false

    when errored do
      displayFlex
      justifyContentCenter
      backgroundColor loadingGrey

    when loading' do 
      loading
