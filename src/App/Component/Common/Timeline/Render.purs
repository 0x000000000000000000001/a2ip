module App.Component.Common.Timeline.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Timeline.Style.Date as Date
import App.Component.Common.Timeline.Style.Dates as Dates
import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Number as Number
import App.Component.Common.Timeline.Style.Numbers as Numbers
import App.Component.Common.Timeline.Style.Pin as Pin
import App.Component.Common.Timeline.Style.Sheet (sheet)
import App.Component.Common.Timeline.Style.Timeline (classId, classIdWhenLoading)
import App.Component.Common.Timeline.Type (Action(..), Slots, State, date)
import App.Component.Common.Timeline.Util (dateToDataAttr)
import App.Util.Capability.AppM (AppM)
import Data.Date (day, month, year)
import Data.Enum (fromEnum)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Events (onClick)
import Util.Html.Dom (dataAttr)
import Util.String (padLeft)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ classes 
        [ classId 
        , s.loading ? classIdWhenLoading ↔ ""
        ]
    ]
    [ sheet
    , div
        [ class_ Line.classId ]
        []
    , div
        [ class_ Dates.classId ]
        ( s.dates <#> \date_ ->
            let y = fromEnum $ year date_
                m = fromEnum $ month date_
                d = fromEnum $ day date_
                dateId = dateToDataAttr $ Just date_
            in ( div
                [ classes $ 
                    [Date.classId] 
                    <> (not s.loading && Just date_ == s.selectedDate ? [Date.classIdWhenSelected] ↔ [])
                , onClick $ κ $ SelectDate date_
                , dataAttr date dateId
                ]
                [ div
                    [ class_ Numbers.classId ]
                    [ div [ class_ Number.classId ] [ text $ padLeft 2 '0' $ show d ]
                    , div [ class_ Number.classId ] [ text $ padLeft 2 '0' $ show m ]
                    , div [ class_ Number.classId ] [ text $ padLeft 2 '0' $ show $ y `mod` 100 ]
                    ]
                , div
                    [ class_ Pin.classId ]
                    []
                ]
            )
        )
    ]
