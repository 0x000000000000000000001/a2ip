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
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Core (AttrName(..), attr)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties as HP
import Util.String (padLeft)
import Util.Style (class_, classes)

dataAttr :: ∀ r i. String -> String -> HP.IProp r i
dataAttr name value = HP.IProp (attr Nothing (AttrName name) value)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ classId
    ]
    [ sheet
    , div
        [ class_ Line.classId ]
        []
    , div
        [ class_ Dates.classId ]
        ( s.dates <#> \date ->
            let d = unwrap date
                dateId = show d.day <> "-" <> show d.month <> "-" <> show d.year
            in ( div
                [ classes $ 
                    [Date.classId] 
                    <> (Just date == s.selectedDate ? [Date.classIdWhenSelected] ↔ [])
                , onClick $ κ $ SelectDate date
                , dataAttr "data-date" dateId
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
