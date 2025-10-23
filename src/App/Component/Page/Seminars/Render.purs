module App.Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import App.Util.Capability.AppM.AppM (AppM)
import App.Component.Common.Timeline.Component (component) as TimelineComponent
import App.Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import App.Component.Page.Seminars.Style.DateContent as DateContent
import App.Component.Page.Seminars.Style.Seminars (classId)
import App.Component.Page.Seminars.Style.Sheet (sheet)
import App.Component.Page.Seminars.Style.Timeline as Timeline
import App.Component.Page.Seminars.Type (Action, Slots, State, dates, timeline)
import App.Component.Util.Type (noSlotAddressIndex)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, slot, text)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ classId ]
    [ sheet
    , div
        [ class_ Timeline.classId ]
        [ slot
            timeline
            noSlotAddressIndex
            TimelineComponent.component
            { class_: Nothing
            , dates
            }
            handleTimelineOutput
        ]
    , div
        [ class_ DateContent.classId ]
        [ text $ "selected: " <> show s.selectedDate
        ]
    ]
