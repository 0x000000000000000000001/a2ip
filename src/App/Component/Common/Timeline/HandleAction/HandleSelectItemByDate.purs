module App.Component.Common.Timeline.HandleAction.HandleSelectItemByDate
  ( handleSelectItemByDate
  ) where

import Proem

import App.Component.Common.Timeline.Type (Output(..), TimelineM, Item)
import Data.Array (find)
import Data.Date (Date)
import Data.Maybe (Maybe(..))
import Halogen (get, modify_, raise)

handleSelectItemByDate :: Date -> TimelineM Unit
handleSelectItemByDate date = do
  state <- get 
  
  let items = state.input.items
      item = find (_.date == date) items

  modify_ _ { selectedItem = item }

  raise $ SelectedDate $ date