module App.Component.Common.YouTubeVideo.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.YouTubeVideo.Style.YouTubeVideo as YouTubeVideo

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  YouTubeVideo.style 