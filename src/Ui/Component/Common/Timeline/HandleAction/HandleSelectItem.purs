module Ui.Component.Common.Timeline.HandleAction.HandleSelectItem
  ( handleSelectItem
  ) where

import Proem

import Ui.Component.Common.Timeline.Type (Output(..), TimelineM, Item)
import Data.Maybe (Maybe(..))
import Halogen (modify_, raise)

handleSelectItem :: ∀ w i. Item w i -> TimelineM w i Unit
handleSelectItem item = do
  modify_ _ { selectedItem = Just item }
  raise $ SelectedDate $ Just item.date