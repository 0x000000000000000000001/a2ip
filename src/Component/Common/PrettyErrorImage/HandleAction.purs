module Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  )
  where

import Prelude

import Capability.AppM (AppM)
import Capability.Log (debug)
import Component.Common.PrettyErrorImage.Type (State, Slots, Action(..), Output)
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of  
  HandleError -> do 
    debug "abc"
    modify_ _ { errored = true } 