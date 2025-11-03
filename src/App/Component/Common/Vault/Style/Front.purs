module App.Component.Common.Vault.Style.Front
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, column, flexDirection, rgba, zIndex)
import CSS as CSS
import Util.Style (alignItemsCenter, displayFlex, heightPct100, heightRem, justifyContentCenter, margin1, positionRelative, svg, topLeftToTopLeft, widthPct100, widthRem, (.?), (.|*:), (:?))

classId :: String
classId = "j8djWsw23"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    topLeftToTopLeft
    zIndex 2
    backgroundColor $ rgba 0 0 0 0.75
    widthPct100
    heightPct100
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column

  __svg :? do 
    widthRem 4.0
    heightRem 4.0
    margin1 1.2

  where 
  __svg = classId .|*: svg