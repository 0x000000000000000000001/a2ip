module App.Component.Common.Carrousel.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Carrousel.Style.Carrousel as Carrousel
import App.Component.Common.Carrousel.Style.Counter as Counter
import App.Component.Common.Carrousel.Style.Control.Index as Control

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Carrousel.style 
  Control.style 
  Counter.style 
