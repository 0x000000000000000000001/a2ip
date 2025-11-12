module App.Component.Common.Carrousel.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Style.Caption (caption_)
import App.Component.Common.Carrousel.Style.Carrousel (carrousel_)
import App.Component.Common.Carrousel.Style.Control.Control (control)
import App.Component.Common.Carrousel.Style.Control.Icon (icon_)
import App.Component.Common.Carrousel.Style.Counter (counter_)
import App.Component.Common.Carrousel.Style.Media (media_)
import App.Component.Common.Carrousel.Style.Sheet (sheet)
import App.Component.Common.Carrousel.Type (Action(..), Media(..), Slots, State)
import App.Component.Common.PrettyErrorImage.Component (prettyErrorImage)
import App.Component.Common.PrettyErrorImage.Type (defaultInput, defaultStyle)
import App.Component.Common.YoutubeVideo.Component (youtubeVideo)
import App.Component.Util.Type (Size(..), noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import CSS (darken, white)
import Data.Array (length, (!!))
import Data.Lens ((.~))
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Halogen (ComponentHTML)
import Halogen.HTML (text)
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
import Util.Style.Style (transparent)

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, input: { slides }, index } =
  let
    slide = slides !! index
    media = slide <#> _.media
    caption = trim $ (join $ slide <#> _.caption) ??⇒ ""
  in
    carrousel_
      [ sheet s
      , media_ id
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
                          defaultStyle 
                            # _when ◁ _errored ◁ _backgroundColor .~ (Just transparent)
                            # _questionMark ◁ _when ◁ _errored ◁ _color .~ (Just $ darken 0.16 white)
                            # _fit .~ (Just contain)
                            # _width .~ (Just $ Pct 100.0)
                            # _height .~ (Just $ Pct 100.0)
                      }
                ]
              Just (YoutubeVideo url) ->
                [ youtubeVideo
                    youtubeVideo'
                    noSlotAddressIndex
                    { url 
                    , style: 
                        { width: Just $ Pct 100.0
                        , height: Just $ Pct 100.0
                        }
                    }
                ]
              _ -> []
          )
      , control true
          [ onClick $ κ GoToPrevious ]
          [ icon_ [ text "◀︎" ] ]
      , control false
          [ onClick $ κ GoToNext ]
          [ icon_ [ text "▶︎" ] ]
      , caption == ""
          ? noHtml
          ↔ caption_ [ text caption ]
      , counter_ [ text $ (show $ index + 1) <> " / " <> (show $ length slides) ]
      ]
