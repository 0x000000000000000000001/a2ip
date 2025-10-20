module Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Page.Seminars.Type (Action, Slots, State)
import Halogen (ComponentHTML)
import Halogen.HTML (text)

render :: State -> ComponentHTML Action Slots AppM
render _ = text "seminars"
