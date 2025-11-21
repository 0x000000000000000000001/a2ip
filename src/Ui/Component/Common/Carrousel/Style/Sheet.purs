module Ui.Component.Common.Carrousel.Style.Sheet
  ( sheet
  ) where

import Ui.Component.Common.Carrousel.Style.Caption as Caption
import Ui.Component.Common.Carrousel.Style.Carrousel as Carrousel
import Ui.Component.Common.Carrousel.Style.Control.Index as Control
import Ui.Component.Common.Carrousel.Style.Counter as Counter
import Ui.Component.Common.Carrousel.Style.Media as Media
import Ui.Component.Common.Carrousel.Type (State)
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
