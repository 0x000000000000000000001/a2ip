module Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( classId
  , classIdWhenErrored
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style (displayFlex, justifyContentCenter, loadingGrey, nothing, (.?))

classId :: String
classId = "ZNnop1mxZ"

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