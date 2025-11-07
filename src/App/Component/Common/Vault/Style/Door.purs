module App.Component.Common.Vault.Style.Door
  ( classId
  , classIdWhenLeft
  , classIdWhenRight
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, rgba, zIndex)
import CSS as CSS
import Util.Proxy.Dictionary.Left (left_)
import Util.Proxy.Dictionary.Right (right_)
import Util.Style (heightPct100, refineClass, reflectHashModuleName, topLeftToTopLeft, topRightToTopRight, widthPct, (.?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenLeft :: String
classIdWhenLeft = refineClass classId left_

classIdWhenRight :: String
classIdWhenRight = refineClass classId right_

style :: CSS.CSS
style = do
  classId .? do
    backgroundColor $ rgba 0 0 0 0.75
    widthPct 50.0
    heightPct100
    zIndex 4

  classIdWhenLeft .? do 
    topLeftToTopLeft

  classIdWhenRight .? do
    topRightToTopRight

  
