module Component.Common.Carrousel.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Common.Carrousel.Style.Carrousel as Carrousel

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Carrousel.style 