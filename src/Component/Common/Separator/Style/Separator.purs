module Component.Common.Separator.Style.Separator
  ( classId
  , classIdWithSofa
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, borderBottom, borderColor, justifyContent, rem, solid)
import CSS as CSS
import CSS.Common (center)
import Component.Common.Separator.Style.Text.Text as Text
import Component.Common.Separator.Style.Util (grey)
import Util.Style (backgroundColorWhite, displayFlex, loading, loadingGrey, padding4, paddingTop, positionSticky, top0, widthPct100, (.?), (.|*.), (:?))

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
    padding4 0.6 0.6 0.0 0.6
    borderBottom solid (rem 0.15) grey

  classIdWithSofa .? do
    paddingTop 2.6

  classIdWhenLoading .? do
    borderColor loadingGrey
    
  __text :? do 
    loading

  where 
  __text = classIdWhenLoading .|*. Text.classId