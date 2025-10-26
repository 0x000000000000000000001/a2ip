module App.Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Timeline.Component (component) as TimelineComponent
import App.Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import App.Component.Page.Seminars.Style.Poster as Poster
import App.Component.Page.Seminars.Style.Seminars (classId)
import App.Component.Page.Seminars.Style.Sheet (sheet)
import App.Component.Page.Seminars.Style.Timeline as Timeline
import App.Component.Page.Seminars.Type (Action, Slots, State, mockDates, timeline)
import App.Component.Util.Type (noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..), isNothing)
import Halogen (ComponentHTML)
import Halogen.HTML (div, p_, slot, text)
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
            , dates: s.seminars ?? (\a -> a <#> _.date) ⇔ mockDates
            , loading: isNothing s.seminars
            }
            handleTimelineOutput
        ]
    , div 
        [ class_ Poster.classId ]
        ( s.selectedSeminar 
            ?? (\s_ -> [
              p_ [ text $ "title: " <> show s_.title ],
              p_ [ text $ "theme: " <> show s_.theme ],
              p_ [ text $ "firstname: " <> show s_.firstname ],
              p_ [ text $ "lastname: " <> show s_.lastname ],
              p_ [ text $ "date: " <> show s_.date ]
            ])
            ↔ []
        )
    ]
