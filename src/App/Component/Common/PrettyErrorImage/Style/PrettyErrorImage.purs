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
import Util.Style (displayFlex, justifyContentCenter, loading, loadingGrey, nothing, (.?))

classId :: String
classId = "ZNnop1mxZ"

classIdWhenLoading :: String
classIdWhenLoading = "HxYQxjUQ9"

classIdWhenErrored :: String
classIdWhenErrored = "w2aEZlO9q"

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