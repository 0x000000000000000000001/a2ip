module App.Component.Page.Home.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Page.Home.Type (Action, State, Slots)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (text)

render :: State -> ComponentHTML Action Slots AppM
render _ = text "home"