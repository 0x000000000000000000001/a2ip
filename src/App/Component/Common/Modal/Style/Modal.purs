module App.Component.Common.Modal.Style.Modal
  ( statefulClass
  , statelessClass
  , style
  , zIndex
  )
  where

import Proem hiding (top)

import App.Component.Common.Modal.Type (State)
import App.Component.Router.Menu.Style.Menu as Menu
import CSS (alignItems, backgroundColor, flexStart, rgba)
import CSS as CSS
import CSS.Overflow (overflow, overflowAuto)
import Util.Style (displayFlex, displayNone, heightPct, justifyContentCenter, left0, nothing, positionFixed, refineClassId, reflectHashModuleName, top0, widthPct100, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClassId statelessClass id

zIndex :: Int
zIndex = 1000 + Menu.zIndex

style :: ∀ i. State i -> CSS.CSS
style { id, input: { open } } = do
  statelessClass .? do
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

  statefulClass id .? do
    when open do 
      nothing

    when (not open) do
      displayNone
    