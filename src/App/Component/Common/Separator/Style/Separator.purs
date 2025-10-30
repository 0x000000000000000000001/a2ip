module App.Component.Common.Separator.Style.Separator
  ( classId
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import CSS (borderBottom, borderColor, rem, solid)
import CSS as CSS
import App.Component.Common.Separator.Style.Text.Text as Text
import App.Component.Common.Separator.Style.Util (grey)
import Util.Style (alignItemsCenter, backgroundColorWhite, displayFlex, justifyContentCenter, loading, loadingGrey, padding4, paddingTop, positionSticky, top0, widthPct100, (.?), (.|*.), (:?))

classId :: String
classId = "keWMC9TZj"

classIdWhenLoading :: String
classIdWhenLoading = "K5u7bPEBt"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter
    alignItemsCenter
    widthPct100
    backgroundColorWhite
    positionSticky
    top0
    padding4 0.6 0.6 0.0 0.6
    borderBottom solid (rem 0.15) grey

  classIdWhenLoading .? do
    borderColor loadingGrey
    
  __text :? do 
    loading

  where 
  __text = classIdWhenLoading .|*. Text.classId