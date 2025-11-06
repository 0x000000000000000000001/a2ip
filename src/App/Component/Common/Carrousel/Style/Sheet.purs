module App.Component.Common.Carrousel.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Carrousel.Style.Caption as Caption
import App.Component.Common.Carrousel.Style.Carrousel as Carrousel
import App.Component.Common.Carrousel.Style.Counter as Counter
import App.Component.Common.Carrousel.Style.Media as Media
import App.Component.Common.Carrousel.Style.Control.Index as Control

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Caption.style
  Carrousel.style 
  Control.style 
  Counter.style 
  Media.style
