module App.Component.Common.Tooltip.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Tooltip.Type (Action(..), TooltipM)
import Halogen (modify_)

handleAction :: ∀ w i. Action w i -> (TooltipM w i) Unit
handleAction = case _ of
  Initialize -> ηι

  Receive input -> modify_ _ { input = input }
  