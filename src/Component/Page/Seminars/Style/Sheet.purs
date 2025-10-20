module Component.Page.Seminars.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Page.Seminars.Style.Seminars as Seminars

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Seminars.style  