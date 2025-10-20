module Component.Common.Timeline.Render
  ( render
  ) where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Timeline.Style.Date as Date
import Component.Common.Timeline.Style.Dates as Dates
import Component.Common.Timeline.Style.Line as Line
import Component.Common.Timeline.Style.Number as Number
import Component.Common.Timeline.Style.Numbers as Numbers
import Component.Common.Timeline.Style.Pin as Pin
import Component.Common.Timeline.Style.Sheet (sheet)
import Component.Common.Timeline.Style.Timeline (classId)
import Component.Common.Timeline.Type (Action(..), Slots, State)
import Data.Array (nubEq)
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Events (onClick)
import Util.String (padLeft)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ classId ]
    [ sheet
    , div
        [ class_ Line.classId ]
        []
    , div
        [ class_ Dates.classId ]
        ( s.dates <#> \date ->
            let d = unwrap date
            in ( div
                [ classes $ 
                    [Date.classId] 
                    <> (Just d == s.selectedDate ? [Date.classIdWhenSelected] ↔ [])
                , onClick $ κ $ SelectDate d
                ]
                [ div
                    [ class_ Numbers.classId ]
                    [ div [ class_ Number.classId ] [ text $ padLeft 2 '0' $ show d.day ]
                    , div [ class_ Number.classId ] [ text $ padLeft 2 '0' $ show d.month ]
                    , div [ class_ Number.classId ] [ text $ padLeft 2 '0' $ show $ d.year `mod` 100 ]
                    ]
                , div
                    [ class_ Pin.classId ]
                    []
                ]
            )
        )
    ]
