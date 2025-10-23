module Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import Component.Util.Capability.AppM (AppM)
import Component.Common.Timeline.Component (component) as TimelineComponent
import Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import Component.Page.Seminars.Style.DateContent as DateContent
import Component.Page.Seminars.Style.Seminars (classId)
import Component.Page.Seminars.Style.Sheet (sheet)
import Component.Page.Seminars.Style.Timeline as Timeline
import Component.Page.Seminars.Type (Action, Slots, State, dates, timeline)
import Component.Util.Type (noSlotAddressIndex)
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
