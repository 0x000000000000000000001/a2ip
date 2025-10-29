module App.Component.Common.Modal.Style.Modal
  ( classId
  , style
  , zIndex
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as Menu
import CSS (alignItems, backgroundColor, flexStart, rgba)
import CSS as CSS
import CSS.Overflow (overflow, overflowAuto)
import Util.Style (displayFlex, heightPct, justifyContentCenter, left0, positionFixed, top0, widthPct100, (.?))

classId :: String
classId = "BVUZF1mw8"

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