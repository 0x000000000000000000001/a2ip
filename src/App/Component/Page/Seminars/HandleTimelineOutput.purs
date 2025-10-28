module App.Component.Page.Seminars.HandleTimelineOutput
  ( handleTimelineOutput
  ) where

import App.Component.Common.Timeline.Type (Output(..))
import App.Component.Common.Timeline.Type as Timeline
import App.Component.Page.Seminars.Type (Action(..))

handleTimelineOutput :: Timeline.Output -> Action
handleTimelineOutput (SelectedDate date) = SelectSeminarByDate date
