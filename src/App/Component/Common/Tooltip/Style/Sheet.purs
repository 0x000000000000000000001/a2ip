module App.Component.Common.Tooltip.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Tooltip.Style.Tooltip as Tooltip
import App.Component.Common.Tooltip.Style.Inner as Inner
import App.Component.Common.Tooltip.Style.Outer.Index as Outer

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Tooltip.style 
  Inner.style
  Outer.style