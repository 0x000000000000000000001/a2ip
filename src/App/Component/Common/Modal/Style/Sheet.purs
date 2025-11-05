module App.Component.Common.Modal.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Modal.Style.Modal as Modal

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Modal.style 