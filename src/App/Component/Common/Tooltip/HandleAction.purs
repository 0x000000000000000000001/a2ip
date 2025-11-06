module App.Component.Common.Tooltip.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Tooltip.Type (Action(..), TooltipM, Output(..))
import Halogen (modify_)
import Halogen.Query.HalogenM (raise)

handleAction :: ∀ q i o. Action i o -> (TooltipM q i o) Unit
handleAction = case _ of
  Initialize -> ηι

  Receive input -> modify_ _ { input = input }
  
  RaiseInnerOutput output -> raise (InnerOutputRaised output)
