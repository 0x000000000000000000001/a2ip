module App.Component.Common.Vault.Style.Lock
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (opacity, zIndex)
import CSS as CSS
import Util.Style (heightRem, margin1, positionRelative, svg, widthRem, (.?), (.|*:), (:?))

classId :: String
classId = "dFT4hypu0"

style :: CSS.CSS
style = do
  classId .? do
    margin1 1.2
    opacity 0.9
    positionRelative
    zIndex 5

  __svg :? do 
    widthRem 8.0
    heightRem 8.0

  where 
  __svg = classId .|*: svg

  
