module Component.Page.Seminars.HandleAction
  ( handleAction
  ) where

import Proem

import Capability.AppM (AppM)
import Component.Page.Seminars.Type (Action(..), Slots, State, Output)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of 
  SelectDate date -> modify_ _ { selectedDate = Just date }
