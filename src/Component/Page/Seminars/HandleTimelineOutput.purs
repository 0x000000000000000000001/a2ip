module Component.Page.Seminars.HandleTimelineOutput
  ( handleTimelineOutput
  ) where


import Component.Common.Timeline.Type (Output(..))
import Component.Common.Timeline.Type as Timeline
import Component.Page.Seminars.Type (Action(..))

handleTimelineOutput :: Timeline.Output -> Action
handleTimelineOutput (SelectedDate date) = SelectDate date
