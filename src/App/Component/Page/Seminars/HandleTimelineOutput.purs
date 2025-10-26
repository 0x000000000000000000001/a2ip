module App.Component.Page.Seminars.HandleTimelineOutput
  ( handleTimelineOutput
  ) where

import Proem

import App.Component.Common.Timeline.Type (Output(..))
import App.Component.Common.Timeline.Type as Timeline
import App.Component.Page.Seminars.Type (Action(..))
import Data.Maybe (Maybe(..))

handleTimelineOutput :: Timeline.Output -> Action
handleTimelineOutput (SelectedDate date) = SelectSeminarByDate $ Just date
