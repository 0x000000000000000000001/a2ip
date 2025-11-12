module App.Component.Common.YoutubeVideo.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Loader.Loader (loader)
import App.Component.Common.YoutubeVideo.Style.Sheet (sheet)
import App.Component.Common.YoutubeVideo.Style.YoutubeVideo (youtubeVideo_)
import App.Component.Common.YoutubeVideo.Type (Action, Slots, State)
import App.Util.Capability.AppM (AppM)
import CSS (darken, white)
import Data.String (Pattern(..), Replacement(..), contains, replaceAll)
import Halogen (ComponentHTML)
import Html.Renderer.Halogen (render_)

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, input: { url } } = 
  youtubeVideo_ id
    [ sheet s
    , loader $ darken 0.1 white
    , render_ $ iframe $ convertToEmbedUrl url 
    ]

iframe :: String -> String 
iframe embedUrl = """
<iframe 
  src=" """ <> embedUrl <> """ " 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
  allowfullscreen>
</iframe>
"""

convertToEmbedUrl :: String -> String
convertToEmbedUrl url
  | contains (Pattern "youtu.be/") url = 
      replaceAll (Pattern "youtu.be/") (Replacement "youtube.com/embed/") url
  | contains (Pattern "watch?v=") url = 
      replaceAll (Pattern "watch?v=") (Replacement "embed/") url
  | otherwise = url