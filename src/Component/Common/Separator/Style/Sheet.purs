module Component.Common.Separator.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Component.Common.Separator.Style.Separator as Separator
import Component.Common.Separator.Style.Text.Index as Text
import Component.Common.Separator.Style.Wing.Index as Wing
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Separator.style
  Text.style
  Wing.style