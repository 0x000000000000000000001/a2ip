module Ui.Component.Common.Tooltip.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Ui.Component.Common.Tooltip.Style.Tooltip as Tooltip
import Ui.Component.Common.Tooltip.Style.Inner as Inner
import Ui.Component.Common.Tooltip.Style.Outer.Index as Outer

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Tooltip.style 
  Inner.style
  Outer.style