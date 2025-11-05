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
import Util.Style (heightPct100, topLeftToTopLeft, topRightToTopRight, widthPct, (.?))

classId :: String
classId = "fFGXQ4uVs"

classIdWhenLeft :: String
classIdWhenLeft = "a84Qb0kH6"

classIdWhenRight :: String
classIdWhenRight = "QJHx5CtxJ"

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

  
