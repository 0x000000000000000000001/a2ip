module App.Component.Page.Seminars.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Page.Seminars.Style.Seminars as Seminars
import App.Component.Page.Seminars.Style.Timeline as Timeline
import App.Component.Page.Seminars.Style.Poster as Poster

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Poster.style
  Seminars.style  
  Timeline.style  