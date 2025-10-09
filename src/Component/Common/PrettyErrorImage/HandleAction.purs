module Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  )
  where

import Prelude

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (State, Slots, Action, Output)
import Halogen (HalogenM) 

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction _ = pure unit