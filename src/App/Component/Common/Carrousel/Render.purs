module App.Component.Common.Carrousel.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Style.Caption as Caption
import App.Component.Common.Carrousel.Style.Carrousel (classId)
import App.Component.Common.Carrousel.Style.Control.Control as Control
import App.Component.Common.Carrousel.Style.Control.Icon as Icon
import App.Component.Common.Carrousel.Style.Counter as Counter
import App.Component.Common.Carrousel.Style.Media as Media
import App.Component.Common.Carrousel.Style.Sheet (sheet)
import App.Component.Common.Carrousel.Type (Action(..), Media(..), Slots, State, _image, _youtubeVideo)
import App.Component.Common.Loader.Loader (loader)
import App.Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import App.Component.Common.YoutubeVideo.Component (youtubeVideo)
import App.Component.Common.YoutubeVideo.Component as YoutubeVideo
import App.Component.Util.Type (noHtml, noOutputAction, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import CSS (darken)
import Color (white)
import Data.Array (length, (!!))
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Halogen (ComponentHTML)
import Halogen.HTML (div, slot, text)
import Halogen.HTML.Events (onClick)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render { input: { slides }, index } =
  let
    slide = slides !! index
    media = slide <#> _.media
    caption = trim $ (join $ slide <#> _.caption) ??⇒ ""
  in
    div
      [ class_ classId ]
      [ sheet
      , div
          [ classes
              [ Media.classId
              , case media of
                  Just (YoutubeVideo _) -> Media.classIdWhenYoutubeVideo
                  _ -> ""
              ]
          ]
          ( case media of
              Just (Image url) ->
                [ slot
                    _image
                    noSlotAddressIndex
                    PrettyErrorImage.component
                    { class_: Nothing
                    , loading: false
                    , sources: 
                        { first: url
                        , fallback: Nothing
                        }
                    }
                    noOutputAction
                ]
              Just (YoutubeVideo url) ->
                [ loader $ darken 0.1 white
                , youtubeVideo
                    _youtubeVideo
                    noSlotAddressIndex
                    { url }
                    noOutputAction
                ]
              _ -> []
          )
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
      , caption == ""
          ? noHtml
          ↔ div
              [ class_ Caption.classId ]
              [ text caption ]
      , div
          [ class_ Counter.classId ]
          [ text $ (show $ index + 1) <> " / " <> (show $ length slides) ]
      ]
