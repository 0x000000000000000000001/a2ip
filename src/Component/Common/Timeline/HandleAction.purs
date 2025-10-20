module Component.Common.Timeline.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Component.Common.Timeline.Type (Action(..), Output(..), Slots, State)
import Data.Array (nubEq)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM, modify_, raise)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of 
  SelectDate date -> do 
    modify_ _ { selectedDate = Just date }
    raise $ SelectedDate date
  Receive input -> modify_ _ { class_ = input.class_, dates = input.dates # nubEq }