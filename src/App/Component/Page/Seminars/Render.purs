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
import App.Component.Page.Seminars.Type (Action(..), Slots, State, mockDates, themeDescription, timeline, youtubeVideo)
import App.Component.Util.Type (noHtml, noOutputAction, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..), isNothing)
import Halogen (ComponentHTML)
import Halogen.HTML (div, div_, p, p_, slot, text)
import Halogen.HTML.Events (onClick)
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
            , defaultDate: LastBeforeNow
            }
            handleTimelineOutput
        ]
    , div 
        [ class_ Poster.classId ]
        ( ( s.selectedSeminar 
              ?? (\s_ -> [
                p_ [ text $ "title: " <> show s_.title ],
                p [ onClick $ κ $ OpenThemeDescriptionModal ] [ text $ "theme " <> (s.openThemeDescriptionModal ? "open" ↔ "closed") <> ": " <> show s_.theme ],
                p_ [ text $ "firstname: " <> show s_.firstname ],
                p_ [ text $ "lastname: " <> show s_.lastname ],
                p_ [ text $ "date: " <> show s_.date <> " de 18 à 20h" ]
              ])
              ↔ []
          ) <> 
          -- Aside, because the array above depends on s.openThemeDescriptionModal
          -- We don't want to rerender the video because of modal opening/closing...
          [ s.selectedSeminar 
              ?? (\s_ -> 
                s_.videoUrl /= ""
                  ? slot
                      youtubeVideo
                      noSlotAddressIndex
                      YoutubeVideoComponent.component
                      { url: s_.videoUrl }
                      noOutputAction
                  ↔ noHtml
              )
              ↔ noHtml
          ]
        )
    , s.openThemeDescriptionModal 
        ? slot
            themeDescription
            noSlotAddressIndex
            (Modal.component Fragment.component)
            { closable: true
            , innerInput: div_ [ text "blablah" ]
            }
            handleThemeDescriptionModalOutput
        ↔ noHtml
    ]
