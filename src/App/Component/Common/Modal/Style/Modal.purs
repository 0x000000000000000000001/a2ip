module App.Component.Common.Modal.Style.Modal
  ( class'
  , staticClass
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
import Util.Style.Style (displayFlex, displayNone, heightPct, justifyContentCenter, left0, noCss, positionFixed, inferClass, reflectStaticClass, top0, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

zIndex :: Int
zIndex = 1000 + Menu.zIndex

style :: ∀ i. State i -> CSS.CSS
style { id, input: { open } } = do
  staticClass .? do
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

  class' id .? do
    when open do 
      noCss

    when (not open) do
      displayNone
    