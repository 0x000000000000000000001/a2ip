module Component.Common.Separator.Style.Separator
  ( classId
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems)
import CSS as CSS
import CSS.Common (center)
import Component.Common.Separator.Style.Text as Text
import Component.Common.Separator.Style.Wing as Wing
import Util.Style (displayFlex, loading, nothing, padding4, widthPct100, (.?), (.|*.), (:?))

classId :: String
classId = "keWMC9TZj"

classIdWhenLoading :: String
classIdWhenLoading = "K5u7bPEBt"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    alignItems center
    widthPct100
    padding4 1.6 0.8 0.6 0.8

  classIdWhenLoading .? do
    nothing
    
  __text :? do 
    loading

  __wing :? do 
    loading

  where 
  __text = classIdWhenLoading .|*. Text.classId
  __wing = classIdWhenLoading .|*. Wing.classId