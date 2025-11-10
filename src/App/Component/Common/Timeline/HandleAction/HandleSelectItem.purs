module App.Component.Common.Timeline.HandleAction.HandleSelectItem
  ( handleSelectItem
  ) where

import Proem

import App.Component.Common.Timeline.Type (Output(..), TimelineM, Item)
import Data.Maybe (Maybe(..))
import Halogen (modify_, raise)

handleSelectItem :: Item -> TimelineM Unit
handleSelectItem item = do
  modify_ _ { selectedItem = Just item }
  raise $ SelectedDate $ Just item.date