module App.Component.Common.Modal.Style.Modal
  ( classId
  , classIdWhenClosed
  , classIdWhenOpen
  , style
  , zIndex
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as Menu
import CSS (alignItems, backgroundColor, flexStart, rgba)
import CSS as CSS
import CSS.Overflow (overflow, overflowAuto)
import Util.Style (displayFlex, displayNone, heightPct, justifyContentCenter, left0, nothing, positionFixed, refineClassId, reflectHashModuleName, top0, widthPct100, (.?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenOpen :: String
classIdWhenOpen = refineClassId classId "open"

classIdWhenClosed :: String
classIdWhenClosed = refineClassId classId "closed"

zIndex :: Int
zIndex = 1000 + Menu.zIndex

style :: CSS.CSS
style = do
  classId .? do
    positionFixed
    top0
    left0
    displayFlex
    justifyContentCenter
    alignItems flexStart
    widthPct100
    heightPct 100.0
    backgroundColor $ rgba 0 0 0 0.75
    CSS.zIndex zIndex
    overflow overflowAuto

  classIdWhenClosed .? do 
    displayNone

  classIdWhenOpen .? do
    nothing
