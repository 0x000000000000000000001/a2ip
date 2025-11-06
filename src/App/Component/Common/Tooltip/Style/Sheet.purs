module App.Component.Common.Tooltip.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Tooltip.Style.Tooltip as Tooltip

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Tooltip.style 