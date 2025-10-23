module App.Component.Common.Modal.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Modal.Type (Action, Slots, State)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (text)

render :: State -> ComponentHTML Action Slots AppM
render _ = text "modal"