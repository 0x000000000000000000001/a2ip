module App.Component.Common.Timeline.Render
  ( render
  )
  where

import Proem hiding (div)

import App.Component.Common.Timeline.Style.Date as Date
import App.Component.Common.Timeline.Style.DownArrow as DownArrow
import App.Component.Common.Timeline.Style.Item as Item
import App.Component.Common.Timeline.Style.Items as Items
import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Number as Number
import App.Component.Common.Timeline.Style.Pin as Pin
import App.Component.Common.Timeline.Style.Sheet (sheet)
import App.Component.Common.Timeline.Style.Timeline (staticClass, staticClassWhenLoading)
import App.Component.Common.Timeline.Type (Action(..), Slots, State)
import App.Component.Common.Timeline.Util (dateToDataAttr)
import App.Component.Common.Tooltip.Tooltip (tooltip)
import App.Component.Common.Tooltip.Type (defaultInput)
import App.Component.Util.Type (Size(..), noHtml)
import App.Util.Capability.AppM (AppM)
import Data.Array (length, mapWithIndex, (!!))
import Data.Date (day, month, year)
import Data.Enum (fromEnum)
import Data.Maybe (Maybe(..), isJust)
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Events (onClick)
import Html.Renderer.Halogen as HRH
import Util.Html.Dom (dataAttr)
import Util.Proxy.Dictionary.Date (date')
import Util.String (padLeft)
import Util.Style.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render { input: { items, loading }, selectedItem } =
  div
    [ classes 
        [ staticClass 
        , loading ? staticClassWhenLoading ↔ ""
        ]
    ]
    [ sheet
    , div
        [ class_ Line.staticClass ]
        []
    , div
        [ class_ Items.staticClass ]
        ( 
            mapWithIndex 
            (\idx item@{ date: date_ } ->
                let y = fromEnum $ year date_
                    m = fromEnum $ month date_
                    d = fromEnum $ day date_
                    dateDataAttr = dateToDataAttr date_
                    isSelected = Just item == selectedItem
                    next = items !! (idx + 1)
                    isNextSelected = isJust next && next == selectedItem
                in 
                    tooltip
                        defaultInput
                            { disabled = loading
                            , outer = text item.label
                            , inner = 
                                div
                                    [ classes $ 
                                        [Item.staticClass] 
                                        <> (not loading && isSelected ? [Item.staticClassWhenSelected] ↔ [])
                                    , onClick $ κ $ SelectItem item
                                    , dataAttr date' dateDataAttr
                                    ]
                                    [ div
                                        [ class_ Date.staticClass ]
                                        [ div [ class_ Number.staticClass ] [ text $ padLeft 2 '0' $ show d ]
                                        , div [ class_ Number.staticClass ] [ text $ padLeft 2 '0' $ show m ]
                                        , div [ class_ Number.staticClass ] [ text $ padLeft 2 '0' $ show $ y `mod` 100 ]
                                        ]
                                    , div
                                        [ class_ Pin.staticClass ]
                                        [ 
                                            0 == idx `mod` 3 
                                            && idx /= length items - 1
                                            && not isSelected
                                            && not isNextSelected
                                                ? HRH.render [ class_ DownArrow.staticClass ] downArrowSvg
                                                ↔ noHtml
                                        ]
                                    ]
                            , style =
                                { offset: Just 0.5
                                , minWidth: Just $ Rem 14.0
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
