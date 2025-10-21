module Component.Common.Separator.Style.Sheet
  ( sheet
  ) where

import Component.Common.Separator.Style.Separator as Separator
import Component.Common.Separator.Style.Text.Index as Text
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Proem (discard)

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Separator.style
  Text.style