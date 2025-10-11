module Component.Common.Link.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Component.Common.Link.Type (State, Slots, Action(..), Output)
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of  
  Receive input -> modify_ _ { href = input.href }