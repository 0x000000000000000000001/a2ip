module App.Component.Common.Vault.Style.Door
  ( staticClass
  , staticClassWhenLeft
  , staticClassWhenRight
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, rgba, zIndex)
import CSS as CSS
import Util.Proxy.Dictionary.Left (left_)
import Util.Proxy.Dictionary.Right (right_)
import Util.Style.Style (heightPct100, refineClass', reflectStaticClass, topLeftToTopLeft, topRightToTopRight, widthPct, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenLeft :: String
staticClassWhenLeft = refineClass' staticClass left_

staticClassWhenRight :: String
staticClassWhenRight = refineClass' staticClass right_

style :: CSS.CSS
style = do
  staticClass .? do
    backgroundColor $ rgba 0 0 0 0.75
    widthPct 50.0
    heightPct100
    zIndex 4

  staticClassWhenLeft .? do 
    topLeftToTopLeft

  staticClassWhenRight .? do
    topRightToTopRight

  
