module Component.Router.Menu.HandleAction (handleAction) where

import Proem hiding (top, div)

import Capability.AppM (AppM)
import Component.Router.Menu.Type (Action(..), Output, State, Slots)
import Halogen (HalogenM, modify_)
 
handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  ToggleFolding bool -> modify_ _ { isUnfold = not bool }