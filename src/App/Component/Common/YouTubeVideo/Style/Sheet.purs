module App.Component.Common.YoutubeVideo.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.YoutubeVideo.Style.YoutubeVideo as YoutubeVideo

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  YoutubeVideo.style 