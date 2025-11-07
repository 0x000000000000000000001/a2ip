module App.Component.Common.Carrousel.Style.Sheet
  ( sheet
  ) where

import App.Component.Common.Carrousel.Style.Caption as Caption
import App.Component.Common.Carrousel.Style.Carrousel as Carrousel
import App.Component.Common.Carrousel.Style.Control.Index as Control
import App.Component.Common.Carrousel.Style.Counter as Counter
import App.Component.Common.Carrousel.Style.Media as Media
import App.Component.Common.Carrousel.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Proem (discard)

sheet :: ∀ w i. State -> HTML w i
sheet s = stylesheet do
  Caption.style
  Carrousel.style 
  Control.style 
  Counter.style 
  Media.style s
