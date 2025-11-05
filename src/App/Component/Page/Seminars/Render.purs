module App.Component.Page.Seminars.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Fragment.Component (fragment)
import App.Component.Common.Fragment.Component as Fragment
import App.Component.Common.Modal.Component (modal)
import App.Component.Common.Timeline.Component (timeline)
import App.Component.Common.Timeline.Type (DefaultDate(..))
import App.Component.Common.Vault.Component (vault)
import App.Component.Common.YoutubeVideo.Component as YoutubeVideo
import App.Component.Page.Seminars.HandleThemeDescriptionModalOutput (handleThemeDescriptionModalOutput)
import App.Component.Page.Seminars.HandleTimelineOutput (handleTimelineOutput)
import App.Component.Page.Seminars.HandleVideoRecordOutput (handleVideoRecordOutput)
import App.Component.Page.Seminars.Style.Poster as Poster
import App.Component.Page.Seminars.Style.Seminars (classId)
import App.Component.Page.Seminars.Style.Sheet (sheet)
import App.Component.Page.Seminars.Style.Timeline as Timeline
import App.Component.Page.Seminars.Type (Action(..), Slots, State, mockDates, themeInfo)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Halogen (ComponentHTML)
import Halogen.HTML (div, div_, p, p_, text)
import Halogen.HTML.Elements.Keyed as HK
import Halogen.HTML.Events (onClick)
import Network.RemoteData (RemoteData(..), isLoading, toMaybe)
import Type.Prelude (Proxy(..))
import Util.Proxy.Dictionary.ThemeDescription (themeDescription')
import Util.Proxy.Dictionary.Timeline (timeline')
import Util.Proxy.Dictionary.VideoRecord (videoRecord')
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ classId ]
    [ sheet
    , div
        [ class_ Timeline.classId ]
        [ timeline
            timeline'
            noSlotAddressIndex
            { class_: Nothing
            , dates: toMaybe s ?? (\s_ -> s_.seminars <#> _.date) ⇔ mockDates
            , loading: isLoading s
            , defaultDate: LastBeforeNow
            }
            handleTimelineOutput
        ]
    , div 
        [ class_ Poster.classId ]
        ( case s of 
            Success { selectedSeminar: Just { seminar, openThemeDescriptionModal } } ->
              [ 
              (p_ [ text $ "title: " <> seminar.title ])
              ,  (p [ onClick $ κ $ OpenThemeDescriptionModal ] [ text $ "theme " <> (openThemeDescriptionModal ? "open" ↔ "closed") <> ": " <> show seminar.theme ])
              , 
                  (
                    openThemeDescriptionModal
                      ? (
                        modal
                          Fragment.component
                          themeDescription'
                          noSlotAddressIndex
                          { closable: true
                          , innerInput: text (themeInfo seminar.theme).description
                          }
                          handleThemeDescriptionModalOutput
                      ) ↔ fragment 
                          (Proxy :: Proxy "themeDescription2")
                          noSlotAddressIndex
                          (text "")
                  )
                  ,  (
                    seminar.videoUrl == "" ? noHtml ↔
                      vault 
                          YoutubeVideo.component
                          videoRecord'
                          noSlotAddressIndex
                          { innerInput:
                              { url: seminar.videoUrl
                              }
                          , password: "pwd"
                          }
                          handleVideoRecordOutput
                  )
              ,  (p_ [ text $ "firstname: " <> seminar.firstname ])
              ,  (p_ [ text $ "lastname: " <> seminar.lastname ])
              ,  (p_ [ text $ "date: " <> show seminar.date <> " de 18 à 20h" ])
              ]
            _ -> []
        )
    ] 
