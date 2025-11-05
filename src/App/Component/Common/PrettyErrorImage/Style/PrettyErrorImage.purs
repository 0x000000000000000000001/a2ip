module App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( classId
  , classIdWhenErrored
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor)
import CSS as CSS
import Util.Proxy.Dictionary.Errored (errored_)
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Style (displayFlex, justifyContentCenter, loading, loadingGrey, nothing, refine, reflectHashModuleName, (.?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenLoading :: String
classIdWhenLoading = refine classId loading_

classIdWhenErrored :: String
classIdWhenErrored = refine classId errored_

style :: CSS.CSS
style = do
  classId .? do 
    nothing
    
  classIdWhenErrored .? do
    displayFlex
    justifyContentCenter
    backgroundColor loadingGrey

  classIdWhenLoading .? do
    loading