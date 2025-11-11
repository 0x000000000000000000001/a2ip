module App.Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Fragment.Component as Fragment
import App.Component.Common.Modal.Component (modal)
import App.Component.Common.Timeline.Component (timeline)
import App.Component.Common.Timeline.Type (DefaultDate(..))
import App.Component.Common.Vault.Component (vault)
import App.Component.Common.YoutubeVideo.Component as YoutubeVideo
import App.Component.Common.YoutubeVideo.Type (defaultStyle)
import App.Component.Page.Seminars.HandleThemeDescriptionModalOutput (handleThemeDescriptionModalOutput)
import App.Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import App.Component.Page.Seminars.HandleVideoRecordOutput (handleVideoRecordOutput)
import App.Component.Page.Seminars.Style.Poster as Poster
import App.Component.Page.Seminars.Style.Seminars (staticClass)
import App.Component.Page.Seminars.Style.Sheet (sheet)
import App.Component.Page.Seminars.Style.Timeline as Timeline
import App.Component.Page.Seminars.Type (Action(..), Slots, State, mockItems, themeInfo)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import CSS (alignItems, flexStart)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (br_, div, div_, p, p_, span_, strong_, text)
import Halogen.HTML.CSS (style)
import Halogen.HTML.Events (onClick)
import Network.RemoteData (RemoteData(..), isLoading, toMaybe)
import Util.Condition ((?), (↔))
import Util.Html.Clean (clean)
import Util.Proxy.Dictionary.ThemeDescription (themeDescription')
import Util.Proxy.Dictionary.Timeline (timeline')
import Util.Proxy.Dictionary.VideoRecord (videoRecord')
import Util.Style.Style (class_, displayFlex, flexGrow1, fontSizePct, justifyContentCenter, minWidthRem, padding1, positionRelative)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ staticClass ]
    [ sheet
    , div
        [ class_ Timeline.staticClass ]
        [ timeline
            timeline'
            noSlotAddressIndex
            { items: 
                toMaybe s 
                    ?? (\s_ -> 
                            s_.seminars <#> 
                            \s' -> 
                                { date: s'.date
                                , label:  
                                    let s'' = clean s'.title 
                                        isEmpty = s'' == ""
                                    in  
                                        div_ 
                                            [ isEmpty 
                                                    ? text "Vous ?" 
                                                    ↔ div 
                                                        [ style do
                                                            minWidthRem 14.0 
                                                            displayFlex
                                                            justifyContentCenter
                                                            alignItems flexStart
                                                        ] 
                                                        [ div 
                                                            [ style do 
                                                                fontSizePct 240.0 
                                                                positionRelative
                                                            ] 
                                                            [ text "“" ]
                                                        , div 
                                                            [ style do 
                                                                flexGrow1
                                                                padding1 0.5
                                                            ] 
                                                            [ text s'' ]
                                                        ]
                                            , isEmpty ? noHtml ↔ br_
                                            , isEmpty ? noHtml ↔ br_
                                            , isEmpty 
                                                    ? noHtml 
                                                    ↔ span_ 
                                                        [ text $ clean s'.firstname <> " "
                                                        , strong_ [ text $ clean s'.lastname ] 
                                                        ]
                                            ]
                                }
                    ) 
                    ⇔ mockItems
            , loading: isLoading s
            , defaultDate: LastBeforeNow
            }
            handleTimelineOutput
        ]
    , div 
        [ class_ Poster.staticClass ]
        ( case s of 
            Success { selectedSeminar: Just { seminar, openThemeDescriptionModal } } ->
                [ p_ [ text $ "title: " <> seminar.title ]
                , p [ onClick $ κ $ OpenThemeDescriptionModal ] [ text $ "theme " <> (openThemeDescriptionModal ? "open" ↔ "closed") <> ": " <> show seminar.theme ]
                , modal
                    Fragment.component
                    themeDescription'
                    noSlotAddressIndex
                    { closable: true
                    , open: openThemeDescriptionModal
                    , innerInput: text (themeInfo seminar.theme).description
                    }
                    handleThemeDescriptionModalOutput
                , p_ [ text $ "firstname: " <> seminar.firstname ]
                , p_ [ text $ "lastname: " <> seminar.lastname ]
                , p_ [ text $ "date: " <> show seminar.date <> " de 18 à 20h" ]
                , seminar.videoUrl == "" ? noHtml ↔
                    vault 
                        YoutubeVideo.component
                        videoRecord'
                        seminar
                        { innerInput:
                            { url: seminar.videoUrl
                            , style: defaultStyle
                            }
                        , memoId: show seminar.theme
                        , password: "pwd"
                        }
                        handleVideoRecordOutput
              ]
            _ -> []
        )
    ] 
