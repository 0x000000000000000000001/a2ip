module App.Component.Common.Carrousel.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Style.Caption as Caption
import App.Component.Common.Carrousel.Style.Carrousel (statelessClass)
import App.Component.Common.Carrousel.Style.Control.Control as Control
import App.Component.Common.Carrousel.Style.Control.Icon as Icon
import App.Component.Common.Carrousel.Style.Counter as Counter
import App.Component.Common.Carrousel.Style.Media as Media
import App.Component.Common.Carrousel.Style.Sheet (sheet)
import App.Component.Common.Carrousel.Type (Action(..), Media(..), Slots, State)
import App.Component.Common.PrettyErrorImage.Component (prettyErrorImage)
import App.Component.Common.PrettyErrorImage.Type (defaultInput, defaultInputStyle)
import App.Component.Common.YoutubeVideo.Component (youtubeVideo)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import CSS (darken, pct, white)
import Data.Array (length, (!!))
import Data.Lens ((.~))
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Events (onClick)
import Util.Proxy.Dictionary.BackgroundColor (_backgroundColor)
import Util.Proxy.Dictionary.Color (_color)
import Util.Proxy.Dictionary.Errored (_errored)
import Util.Proxy.Dictionary.Fit (_fit)
import Util.Proxy.Dictionary.Height (_height)
import Util.Proxy.Dictionary.Image (image')
import Util.Proxy.Dictionary.QuestionMark (_questionMark)
import Util.Proxy.Dictionary.When (_when)
import Util.Proxy.Dictionary.Width (_width)
import Util.Proxy.Dictionary.YoutubeVideo (youtubeVideo')
import Util.Style.Image (contain)
import Util.Style.Style (class_, classes, transparent)

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, input: { slides }, index } =
  let
    slide = slides !! index
    media = slide <#> _.media
    caption = trim $ (join $ slide <#> _.caption) ??⇒ ""
  in
    div
      [ class_ statelessClass ]
      [ sheet s
      , div
          [ classes
              [ Media.statelessClass
              , Media.statefulClass id
              ]
          ]
          ( case media of
              Just (Image url) ->
                [ prettyErrorImage
                    image'
                    noSlotAddressIndex
                    defaultInput
                      { sources =
                          { first: url
                          , fallback: Nothing
                          }
                      , style = 
                          defaultInputStyle 
                            # _when ◁ _errored ◁ _backgroundColor .~ (Just transparent)
                            # _questionMark ◁ _when ◁ _errored ◁ _color .~ (Just $ darken 0.16 white)
                            # _fit .~ (Just contain)
                            # _width .~ (Just $ pct 100.0)
                            # _height .~ (Just $ pct 100.0)
                      }
                ]
              Just (YoutubeVideo url) ->
                [ youtubeVideo
                    youtubeVideo'
                    noSlotAddressIndex
                    { url }
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
              [ class_ Caption.statelessClass ]
              [ text caption ]
      , div
          [ class_ Counter.statelessClass ]
          [ text $ (show $ index + 1) <> " / " <> (show $ length slides) ]
      ]
