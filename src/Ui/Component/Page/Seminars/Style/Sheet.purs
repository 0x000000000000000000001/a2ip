module Ui.Component.Page.Seminars.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Ui.Component.Page.Seminars.Style.Seminars as Seminars
import Ui.Component.Page.Seminars.Style.Timeline.Index as Timeline
import Ui.Component.Page.Seminars.Style.Poster as Poster

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Poster.style
  Seminars.style  
  Timeline.style  