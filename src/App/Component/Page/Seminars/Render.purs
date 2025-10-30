module App.Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Fragment.Component as Fragment
import App.Component.Common.Modal.Component as Modal
import App.Component.Common.Timeline.Component (component) as TimelineComponent
import App.Component.Common.Timeline.Type (DefaultDate(..))
import App.Component.Common.YoutubeVideo.Component (component) as YoutubeVideoComponent
import App.Component.Page.Seminars.HandleThemeDescriptionModalOutput (handleThemeDescriptionModalOutput)
import App.Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import App.Component.Page.Seminars.Style.Poster as Poster
import App.Component.Page.Seminars.Style.Seminars (classId)
import App.Component.Page.Seminars.Style.Sheet (sheet)
import App.Component.Page.Seminars.Style.Timeline as Timeline
import App.Component.Page.Seminars.Type (Action(..), Slots, State(..), mockDates, themeDescription, timeline, youtubeVideo)
import App.Component.Util.Type (noHtml, noOutputAction, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..), isNothing)
import Halogen (ComponentHTML)
import Halogen.HTML (div, div_, p, p_, slot, text)
import Halogen.HTML.Events (onClick)
import Network.RemoteData (RemoteData(..), isLoading, toMaybe)
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
            , dates: toMaybe s ?? (\s_ -> s_.seminars <#> _.date) ⇔ mockDates
            , loading: isLoading s
            , defaultDate: LastBeforeNow
            }
            handleTimelineOutput
        ]
    , div 
        [ class_ Poster.classId ]
        ( ( case s of 
              Success { selectedSeminar: Just { seminar, openThemeDescriptionModal } } ->
                [ p_ [ text $ "title: " <> seminar.title ],
                  p [ onClick $ κ $ OpenThemeDescriptionModal ] [ text $ "theme " <> (openThemeDescriptionModal ? "open" ↔ "closed") <> ": " <> seminar.theme ],
                  openThemeDescriptionModal
                    ? (
                      slot
                        themeDescription
                        noSlotAddressIndex
                        (Modal.component Fragment.component)
                        { closable: true
                        , innerInput: div_ [ text "blablah" ]
                        }
                        handleThemeDescriptionModalOutput
                    ) ↔ noHtml,
                  p_ [ text $ "firstname: " <> seminar.firstname ],
                  p_ [ text $ "lastname: " <> seminar.lastname ],
                  p_ [ text $ "date: " <> show seminar.date <> " de 18 à 20h" ]
                ]
              _ -> []
          ) <> 
          -- Aside, because the array above depends on s.openThemeDescriptionModal
          -- We don't want to rerender the video because of modal opening/closing...
          [ case s of
              Success { selectedSeminar: Just { seminar } } | seminar.videoUrl /= "" ->
                slot
                  youtubeVideo
                  noSlotAddressIndex
                  YoutubeVideoComponent.component
                  { url: seminar.videoUrl }
                  noOutputAction
              _ -> noHtml
          ]
        )
    ]
