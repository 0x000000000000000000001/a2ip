module Component.Common.Timeline.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Component.Common.Timeline.Type (Action(..), Output, Slots, State)
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of 
  Receive input -> modify_ _ { class_ = input.class_, dates = input.dates }