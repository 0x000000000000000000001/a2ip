module App.Component.Common.Timeline.HandleAction.HandleSelectDate
  ( handleSelectDate
  ) where

import Proem

import App.Component.Common.Timeline.Type (Output(..), TimelineM)
import Data.Date (Date)
import Data.Maybe (Maybe(..))
import Halogen (modify_, raise)

handleSelectDate :: Date -> TimelineM Unit
handleSelectDate date = do
  modify_ _ { selectedDate = Just date }
  raise $ SelectedDate $ Just date