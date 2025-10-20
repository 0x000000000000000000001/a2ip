module Component.Common.Carrousel.Style.Sheet
  ( sheet
  ) where

import Prelude (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Common.Carrousel.Style.Carrousel as Carrousel
import Component.Common.Carrousel.Style.Control.Index as Control

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Carrousel.style 
  Control.style 