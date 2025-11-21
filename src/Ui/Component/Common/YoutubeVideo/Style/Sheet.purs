module Ui.Component.Common.YoutubeVideo.Style.Sheet
  ( sheet
  ) where

import Ui.Component.Common.YoutubeVideo.Style.YoutubeVideo as YoutubeVideo
import Ui.Component.Common.YoutubeVideo.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ w i. State -> HTML w i
sheet s = stylesheet do
  YoutubeVideo.style s