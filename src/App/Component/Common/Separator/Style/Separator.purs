module App.Component.Common.Separator.Style.Separator
  ( classId
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Separator.Style.Text.Text as Text
import App.Component.Common.Separator.Style.Util (grey)
import CSS (borderBottom, borderColor, rem, solid)
import CSS as CSS
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Style.Style (alignItemsCenter, backgroundColorWhite, displayFlex, justifyContentCenter, loading, loadingGrey, padding4, positionSticky, refineClass, reflectHashModuleName, top0, widthPct100, (.?), (.|*.), (:?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenLoading :: String
classIdWhenLoading = refineClass classId loading_

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