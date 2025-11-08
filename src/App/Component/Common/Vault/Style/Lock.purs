module App.Component.Common.Vault.Style.Lock
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (opacity, zIndex)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, borderRadiusPct50, displayFlex, heightRem, justifyContentCenter, margin1, positionRelative, reflectStatelessClass, svg, widthRem, (.?), (.|*:), (:?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    margin1 1.2
    opacity 0.9
    positionRelative
    zIndex 5
    borderRadiusPct50
    displayFlex
    justifyContentCenter
    alignItemsCenter

  __svg :? do 
    widthRem 8.0
    heightRem 8.0

  where 
  __svg = classId .|*: svg

  
