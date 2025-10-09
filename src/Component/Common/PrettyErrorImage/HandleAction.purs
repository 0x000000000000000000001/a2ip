module Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  )
  where

import Prelude

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (State, Slots, Action(..), Output)
import Halogen (HalogenM, modify_) 

handleAction :: forall p. Action -> HalogenM (State p) Action Slots Output AppM Unit
handleAction = case _ of 
  HandleError -> modify_ _ { errored = true } 