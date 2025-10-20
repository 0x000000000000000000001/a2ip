module Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Timeline.Component (component) as TimelineComponent
import Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import Component.Page.Seminars.Style.DateContent as DateContent
import Component.Page.Seminars.Style.Seminars (classId)
import Component.Page.Seminars.Style.Sheet (sheet)
import Component.Page.Seminars.Style.Timeline as Timeline
import Component.Page.Seminars.Type (Action, Slots, State, timeline)
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
            , dates:
                [ { day: 1, month: 1, year: 2024 }
                , { day: 15, month: 2, year: 25 }
                , { day: 13, month: 3, year: 25 }
                , { day: 13, month: 3, year: 25 }
                , { day: 13, month: 4, year: 25 }
                , { day: 13, month: 5, year: 25 }
                , { day: 13, month: 6, year: 25 }
                , { day: 13, month: 7, year: 25 }
                , { day: 13, month: 8, year: 25 }
                , { day: 13, month: 9, year: 25 }
                , { day: 13, month: 10, year: 25 }
                , { day: 13, month: 11, year: 25 }
                , { day: 13, month: 12, year: 25 }
                ]
            }
            handleTimelineOutput
        ]
    , div
        [ class_ DateContent.classId ]
        [ text $ "selected: " <> show s.selectedDate
        ]
    ]
