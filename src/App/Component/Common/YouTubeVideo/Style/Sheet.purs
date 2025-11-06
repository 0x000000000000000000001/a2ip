module App.Component.Common.YoutubeVideo.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.YoutubeVideo.Style.YoutubeVideo as YoutubeVideo

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  YoutubeVideo.style 