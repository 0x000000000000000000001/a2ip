module Component.Common.Separator.Style.Separator
  ( classId
  , classIdWithSofa
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, justifyContent)
import CSS as CSS
import CSS.Common (center)
import Component.Common.Separator.Style.Text.Text as Text
import Component.Common.Separator.Style.Wing.End as End
import Component.Common.Separator.Style.Wing.Wing as Wing
import Util.Style (backgroundColorWhite, displayFlex, loading, nothing, padding1, paddingTop, positionSticky, top0, widthPct100, (.?), (.|*.), (:?))

classId :: String
classId = "keWMC9TZj"

classIdWithSofa :: String
classIdWithSofa = "GokzkFUP1"

classIdWhenLoading :: String
classIdWhenLoading = "K5u7bPEBt"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContent center
    alignItems center
    widthPct100
    backgroundColorWhite
    positionSticky
    top0
    padding1 0.6

  classIdWithSofa .? do
    paddingTop 2.6

  classIdWhenLoading .? do
    nothing
    
  __text :? do 
    loading

  __wing :? do 
    loading

  ____end :? do 
    loading

  where 
  __text = classIdWhenLoading .|*. Text.classId
  __wing = classIdWhenLoading .|*. Wing.classId
  ____end = classIdWhenLoading .|*. End.classId