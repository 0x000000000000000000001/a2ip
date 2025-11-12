module App.Component.Common.Timeline.Render
  ( render
  )
  where

import Proem hiding (div)

import App.Component.Common.Timeline.Style.Date (date_)
import App.Component.Common.Timeline.Style.DownArrow (downArrow_)
import App.Component.Common.Timeline.Style.Item (item)
import App.Component.Common.Timeline.Style.Items (items_)
import App.Component.Common.Timeline.Style.Line (line_)
import App.Component.Common.Timeline.Style.Number (number_)
import App.Component.Common.Timeline.Style.Pin (pin_)
import App.Component.Common.Timeline.Style.Sheet (sheet)
import App.Component.Common.Timeline.Style.Timeline (timeline_)
import App.Component.Common.Timeline.Type (Action(..), Slots, State)
import App.Component.Common.Timeline.Util (dateToDataAttr)
import App.Component.Common.Tooltip.Tooltip (tooltip)
import App.Component.Common.Tooltip.Type (defaultInput)
import App.Component.Util.Type (noHtml)
import App.Util.Capability.AppM (AppM)
import Data.Array (length, mapWithIndex, (!!))
import Data.Date (day, month, year)
import Data.Enum (fromEnum)
import Data.Maybe (Maybe(..), isJust)
import Halogen (ComponentHTML)
import Halogen.HTML (text)
import Halogen.HTML.Events (onClick)
import Unsafe.Coerce (unsafeCoerce)
import Util.Html.Dom (dataAttr)
import Util.Proxy.Dictionary.Date (date')
import Util.String (padLeft)

render :: ∀ w i. State w i -> ComponentHTML (Action w i) Slots AppM
render { input: { items, loading }, selectedItem } =
  timeline_ loading
    [ sheet
    , line_
    , items_
        ( 
            mapWithIndex 
            (\idx item'@{ date: _date } ->
                let y = fromEnum $ year _date
                    m = fromEnum $ month _date
                    d = fromEnum $ day _date
                    dateDataAttr = dateToDataAttr _date
                    isSelected = (selectedItem <#> _.date) == Just _date
                    next = items !! (idx + 1)
                    isNextSelected = isJust next && (next <#> _.date) == (selectedItem <#> _.date)
                in 
                    tooltip
                        defaultInput
                            { disabled = loading
                            , outer = unsafeCoerce item'.label
                            , inner = 
                                item (not loading && isSelected)
                                    [ onClick $ κ $ SelectItem item'
                                    , dataAttr date' dateDataAttr
                                    ]
                                    [ date_
                                        [ number_ [ text $ padLeft 2 '0' $ show d ]
                                        , number_ [ text $ monthIntToName m ]
                                        , number_ [ text $ padLeft 2 '0' $ show $ 2000 + y `mod` 100 ]
                                        ]
                                    , pin_
                                        [   0 == idx `mod` 3 
                                            && idx /= length items - 1
                                            && not isSelected
                                            && not isNextSelected
                                                ? (downArrow_ downArrowSvg)
                                                ↔ noHtml
                                        ]
                                    ]
                            , style =
                                { offset: Just 0.5
                                }
                            }
            ) 
            items
        )
    ]

downArrowSvg :: String
downArrowSvg = """
<?xml version="1.0" encoding="utf-8"?><!-- Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools -->
<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
<path d="M5.70711 9.71069C5.31658 10.1012 5.31658 10.7344 5.70711 11.1249L10.5993 16.0123C11.3805 16.7927 12.6463 16.7924 13.4271 16.0117L18.3174 11.1213C18.708 10.7308 18.708 10.0976 18.3174 9.70708C17.9269 9.31655 17.2937 9.31655 16.9032 9.70708L12.7176 13.8927C12.3271 14.2833 11.6939 14.2832 11.3034 13.8927L7.12132 9.71069C6.7308 9.32016 6.09763 9.32016 5.70711 9.71069Z" />
</svg>
"""

monthIntToName :: Int -> String
monthIntToName m = case m of
    1 -> "Jan"
    2 -> "Fév"
    3 -> "Mars"
    4 -> "Avr"
    5 -> "Mai"
    6 -> "Juin"
    7 -> "Juil."
    8 -> "Août"
    9 -> "Sept"
    10 -> "Oct"
    11 -> "Nov"
    12 -> "Déc"
    _ -> "???"
