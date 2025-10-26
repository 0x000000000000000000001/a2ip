module App.Component.Common.YouTubeVideo.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.YouTubeVideo.Style.Sheet (sheet)
import App.Component.Common.YouTubeVideo.Style.YouTubeVideo (classId)
import App.Component.Common.YouTubeVideo.Type (Action, Slots, State)
import App.Util.Capability.AppM (AppM)
import Data.String (Pattern(..), Replacement(..), contains, replaceAll)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Html.Renderer.Halogen (render_)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  div 
    [ class_ classId ]
    [ sheet
    , render_ $ iframe $ convertToEmbedUrl s.url 
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