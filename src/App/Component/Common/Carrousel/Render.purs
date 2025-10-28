module App.Component.Common.Carrousel.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Style.Carrousel (classId, classIdWhenYoutubeVideo)
import App.Component.Common.Carrousel.Style.Control.Control as Control
import App.Component.Common.Carrousel.Style.Control.Icon as Icon
import App.Component.Common.Carrousel.Style.Counter as Counter
import App.Component.Common.Carrousel.Style.Sheet (sheet)
import App.Component.Common.Carrousel.Type (Action(..), Media(..), Slots, State, image, youtubeVideo)
import App.Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import App.Component.Common.YoutubeVideo.Component as YoutubeVideo
import App.Component.Util.Type (noHtml, noOutputAction, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Array (length, (!!))
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, slot, text)
import Halogen.HTML.Events (onClick)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  let media = s.medias !! s.mediaIndex 
  in
  div 
    [ classes 
        [ classId
        , case media of
            Just (YoutubeVideo _) -> classIdWhenYoutubeVideo
            _ -> ""
        ] 
    ]
    [ sheet
    , case media of
        Just (Image url) ->
          slot
            image
            noSlotAddressIndex
            PrettyErrorImage.component
            { src: Just url
            , fallbackSrc: Nothing
            , class_: Nothing
            }
            noOutputAction
        Just (YoutubeVideo url) -> 
          slot
            youtubeVideo
            noSlotAddressIndex
            YoutubeVideo.component
            { url
            }
            noOutputAction
        _ -> noHtml
    , div
      [ classes [ Control.classId, Control.classIdWhenPrev ]
      , onClick $ κ GoToPrevious
      ]
      [ div [ class_ Icon.classId ] [ text "◀︎" ] ]
    , div
      [ classes [ Control.classId, Control.classIdWhenNext ]
      , onClick $ κ GoToNext
      ]
      [ div [ class_ Icon.classId ] [ text "▶︎" ] ]
    , div 
      [ class_ Counter.classId ]
      [ text $ (show $ s.mediaIndex + 1) <> " / " <> (show $ length s.medias) ]
    ]
  