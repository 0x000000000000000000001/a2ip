module Ui.Component.Page.Seminars.HandleTimelineOutput
  ( handleTimelineOutput
  ) where

import Ui.Component.Common.Timeline.Type (Output(..))
import Ui.Component.Common.Timeline.Type as Timeline
import Ui.Component.Page.Seminars.Type (Action(..))

handleTimelineOutput :: Timeline.Output -> Action
handleTimelineOutput (SelectedDate date) = SelectSeminarByDate date
