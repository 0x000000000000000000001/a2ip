module App.Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Fragment.Component as Fragment
import App.Component.Common.Modal.Component (modal)
import App.Component.Common.PrettyErrorImage.Component (prettyErrorImage)
import App.Component.Common.PrettyErrorImage.Type (defaultInput)
import App.Component.Common.Timeline.Component (timeline)
import App.Component.Common.Timeline.Type (DefaultDate(..))
import App.Component.Common.Vault.Component (vault)
import App.Component.Common.YoutubeVideo.Component as YoutubeVideo
import App.Component.Common.YoutubeVideo.Type (defaultStyle)
import App.Component.Page.Seminars.HandleThemeDescriptionModalOutput (handleThemeDescriptionModalOutput)
import App.Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import App.Component.Page.Seminars.HandleVideoRecordOutput (handleVideoRecordOutput)
import App.Component.Page.Seminars.Style.Poster (poster_)
import App.Component.Page.Seminars.Style.Seminars (seminars_)
import App.Component.Page.Seminars.Style.Sheet (sheet)
import App.Component.Page.Seminars.Style.Timeline.Label.Lastname (lastname_)
import App.Component.Page.Seminars.Style.Timeline.Label.Names (names_)
import App.Component.Page.Seminars.Style.Timeline.Label.Person (person_)
import App.Component.Page.Seminars.Style.Timeline.Label.Portrait (prettyErrorImageStyle)
import App.Component.Page.Seminars.Style.Timeline.Label.Quote (quote_)
import App.Component.Page.Seminars.Style.Timeline.Label.Quoted (quoted_)
import App.Component.Page.Seminars.Style.Timeline.Label.Title (title_)
import App.Component.Page.Seminars.Style.Timeline.Timeline (timeline_)
import App.Component.Page.Seminars.Type (Action(..), Slots, State, mockItems, themeInfo)
import App.Component.Page.Util.Image (ourImageRelativePath)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div_, p, p_, text)
import Halogen.HTML.Events (onClick)
import Network.RemoteData (RemoteData(..), isLoading, toMaybe)
import Util.Condition ((?), (↔))
import Util.Html.Clean (clean)
import Util.Proxy.Dictionary.ThemeDescription (themeDescription')
import Util.Proxy.Dictionary.Timeline (timeline')
import Util.Proxy.Dictionary.TimelinePortraits (timelinePortraits')
import Util.Proxy.Dictionary.VideoRecord (videoRecord')
import Util.String (slugify)

render :: State -> ComponentHTML Action Slots AppM
render s =
  seminars_
    [ sheet
    , timeline_
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
                                                    ↔ title_
                                                        [ quote_ [ text "“" ]
                                                        , quoted_ [ text s'' ]
                                                        ]
                                            , isEmpty 
                                                    ? noHtml 
                                                    ↔ person_
                                                        [ names_
                                                            [ div_ [ text $ clean s'.firstname <> " " ]
                                                            , lastname_ [ text $ clean s'.lastname ]
                                                            ] 
                                                        , prettyErrorImage
                                                            timelinePortraits'
                                                            (s'.firstname <> s'.lastname <> show s'.date)
                                                            defaultInput
                                                                { sources = 
                                                                    { first: ourImageRelativePath $ slugify $ clean $ s'.firstname <> " " <> s'.lastname
                                                                    , fallback: Just $ ourImageRelativePath "anonymous"
                                                                    }
                                                                , style = prettyErrorImageStyle
                                                                }
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
    , poster_
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
